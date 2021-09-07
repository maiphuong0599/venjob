class FavoriteJobsController < ApplicationController
  def index
    @favorites = job_query.order_favorite(current_user).page(params[:page])
  end

  def update
    favorite = job_query.find_favorite(job_params, current_user)
    if favorite.empty?
      FavoriteJob.create(job: Job.find(params[:job_id]), user: current_user)
      @favorite_exists = true
    else
      favorite.first.destroy
      @favorite_exists = false
    end
    respond_to do |format|
      format.js {}
    end
  end

  def destroy
    @favorite = job_query.find_favorite(job_params, current_user).first.destroy
    redirect_to favorite_url
    flash[:success] = "#{@favorite.job.title} was completed and destroyed."
  end

  private

  def job_params
    params.permit(:job_id)
  end

  def job_query
    @job_query ||= FavoriteQuery.new
  end
end
