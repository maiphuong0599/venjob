class FavoriteJobsController < ApplicationController
  def show
    @favorites = JobsQuery.new.order_favorite(current_user).page(params[:page])
  end

  def update
    favorite = JobsQuery.new.find_favorite(job_params, current_user)
    if favorite == []
      FavoriteJob.create(job: Job.find(params[:job_id]), user: current_user)
      @favorite_exists = true
    else
      JobsQuery.new.find_favorite(job_params, current_user).first.destroy
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def destroy
    @favorite = JobsQuery.new.find_favorite(job_params, current_user).first.destroy
    redirect_to favorite_url
    flash[:success] = "#{@favorite.job.title} was completed and destroyed."
  end

  private

  def job_params
    params.permit(:job_id)
  end
end
