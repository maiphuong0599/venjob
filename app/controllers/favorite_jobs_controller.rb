class FavoriteJobsController < ApplicationController
  include ApplicationHelper

  before_action :check_params_job, only: %i[update destroy]
  def index
    @favorites = favorite_query.order_favorite(current_user).page(params[:page])
  end

  def update
    favorite = favorite_query.find_favorite(job_params, current_user)
    if favorite.nil?
      FavoriteJob.create(job: @job, user: current_user)
      @favorite_exists = true
    else
      favorite.destroy
      @favorite_exists = false
    end
    respond_to do |format|
      format.html { redirect_to new_user_session_path, alert: 'You need to sign in or sign up before continuing.' }
      format.js {}
    end
  end

  def destroy
    @favorite = favorite_query.find_favorite(job_params, current_user).destroy
    redirect_to favorite_url
    flash[:success] = "#{@favorite.job.title} was completed and destroyed."
  end

  private

  def job_params
    params.permit(:job_id)
  end

  def favorite_query
    @favorite_query ||= FavoriteQuery.new
  end

  def check_params_job
    @job = Job.find_by(id: params[:job_id]) or not_found
  end
end
