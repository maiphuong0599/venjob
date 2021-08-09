class ApplyJobsController < ApplicationController
  def new
  end

  def confirm
    @apply_job = ApplyJob.new(apply_params)
  end

  def done
    @apply_job = ApplyJob.new(apply_params)
    if @apply_job.save
      flash[:success] = "Done!"
      redirect_to confirm_url(@apply_job)
    else
      redirect_to root_url
    end
  end

  private

  def apply_params
    params.permit(:name, :email, :cv)
  end
end
