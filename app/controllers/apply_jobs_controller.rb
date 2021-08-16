class ApplyJobsController < ApplicationController

  def new
    job =  Job.find_by(id: params[:job_id])
    return root_path unless job

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
    @apply_job.user_id = User.find_by(id: 1).id
    if @apply_job.valid?
      @blob = ActiveStorage::Blob.create_and_upload!(
        io: apply_params[:cv],
        filename: apply_params[:cv].original_filename,
        content_type: apply_params[:cv].content_type
      )
      session[:blob_id] = @blob.id
      session[:apply_job] = @apply_job
    else
      render :new
    end
  end

  def done
    @apply_job = ApplyJob.new(apply_params)
    @apply_job.user_id = User.find_by(id: 1).id
    @job = Job.latest_jobs.find(apply_params[:job_id])
    @apply_job.cv = ActiveStorage::Blob.find(session[:blob_id])
    if @apply_job.save
      ApplyJobMailer.with(apply_job: @apply_job, job: @job).create_apply.deliver_now
      flash.now[:success] = 'You have applied successfully'
    else
      flash.now[:danger] = 'Please apply again'
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