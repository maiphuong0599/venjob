class ApplyJobsController < ApplicationController
  def new
    @apply_job = ApplyJob.new
    @apply_job.job_id = params[:job_id]
  end

  def confirm
    @apply_job = ApplyJob.new(apply_params)
    @apply_job.job_id = apply_params[:job_id]
  end

  def done
    @apply_job = ApplyJob.new(apply_params)
    @apply_job.user_id = User.find_by(id: 1).id
    @apply_job.job_id = apply_params[:job_id]
    if @apply_job.save!
      flash.now[:success] = 'Done hehe!'
    else
      redirect_to root_url
    end
  end

  private

  def apply_params
    params.require(:apply_job).permit(:name, :email, :cv)
  end
end
