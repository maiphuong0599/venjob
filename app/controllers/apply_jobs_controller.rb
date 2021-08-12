class ApplyJobsController < ApplicationController
  def new
    job =  Job.find_by(id: params[:job_id])
    return root_path unless job

    @apply_job = if session[:apply_job].present?
                   ApplyJob.new(session[:apply_job])
                 else
                   ApplyJob.new
                 end
    @apply_job.job_id = job.id
  end

  def confirm
    @apply_job = ApplyJob.new(apply_params)
    @apply_job.user_id = User.find_by(id: 1).id
    if @apply_job.valid?
      session[:apply_job] = @apply_job
      render :confirm
    else
      render :new
    end
  end

  def done
    @apply_job = ApplyJob.new(apply_params)
    @apply_job.user_id = User.find_by(id: 1).id
    @job = Job.latest_jobs.find(apply_params[:job_id])
    if @apply_job.save
      ApplyJobMailer.with(apply_job: @apply_job, job: @job).create_apply.deliver_now
      flash.now[:success] = 'You have applied successfully'
    else
      flash.now[:danger] = 'Please apply again'
      redirect_to root_url
    end
    session[:apply_job] = nil
  end

  private

  def apply_params
    params.require(:apply_job).permit(:name, :email, :cv, :job_id)
  end
end
