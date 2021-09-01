class FavoriteJobsController < ApplicationController
  def show
    @favorites = FavoriteJob.order('created_at DESC').page(params[:page])
  end

  def update
    favorite = FavoriteJob.where(job: Job.find(params[:job_id]), user: current_user)
    if favorite == []
      FavoriteJob.create(job: Job.find(params[:job_id]), user: current_user)
      @favorite_exists = true
    else
      FavoriteJob.where(job: Job.find(params[:job_id]), user: current_user).first.destroy
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def destroy
    @favorite = FavoriteJob.where(job: Job.find(params[:job_id]), user: current_user).first.destroy
    redirect_to favorite_url
    flash[:success] = "#{@favorite.job.title} was completed and destroyed."
  end
end
