class ApplyJobsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  def new
    job = Job.find_by(id: params[:job_id]) or not_found

    if session[:apply_job].present?
      @apply_job = ApplyJob.new(session[:apply_job])
      if session[:blob_id].present?
        @blob = ActiveStorage::Blob.find(session[:blob_id])
        @apply_job.assign_attributes(cv: @blob)
      end
    else
      @apply_job = ApplyJob.new
    end
    @apply_job.job = job
  end

  def confirm
    @apply_job = ApplyJob.new(apply_params)
    @apply_job.user_id = current_user.id
    @apply_job.validate
    if @apply_job.cv.attached? && @apply_job.errors[:cv].empty?
      @blob = ActiveStorage::Blob.create_and_upload!(
        io: apply_params[:cv],
        filename: apply_params[:cv].original_filename,
        content_type: apply_params[:cv].content_type
      )
      session[:blob_id] = @blob.id
    elsif @apply_job.cv.attached? && !@apply_job.errors[:cv].empty? && session[:blob_id]
      ActiveStorage::Blob.find_by(id: session[:blob_id]).try(:destroy)
    elsif !@apply_job.cv.attached? && session[:blob_id]
      @blob = ActiveStorage::Blob.find_by(id: session[:blob_id])
      @apply_job.assign_attributes(cv: @blob)
    end
    if @apply_job.valid?
      session[:apply_job] = @apply_job
      return render :confirm
    end
    render :new
  end

  def done
    @apply_job = ApplyJob.new(apply_params)
    @apply_job.user_id = current_user.id
    @job = Job.latest_jobs.find(apply_params[:job_id])
    @apply_job.cv = ActiveStorage::Blob.find(session[:blob_id])
    if @apply_job.save
      ApplyJobMailer.with(apply_job: @apply_job, job: @job).create_apply.deliver_now
      flash.now[:success] = 'You have applied successfully'
    else
      flash[:danger] = 'Have something wrong. Please apply again'
      redirect_to root_url
    end
    session[:apply_job] = nil
    session[:blob_id] = nil
  end

  private

  def apply_params
    params.require(:apply_job).permit(:name, :email, :cv, :job_id, :id)
  end
end