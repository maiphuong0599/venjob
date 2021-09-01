class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  after_action :history_action, only: [:show]

  def index
    if params[:city_slug].present?
      city = City.find_by(slug: params[:city_slug])
      jobs = city.jobs
      @result = city.name
    else
      industry = Industry.find_by(slug: params[:industry_slug])
      jobs = industry.jobs
      @result = industry.name
    end
    @total = jobs.count
    @jobs = jobs.latest_jobs.page(params[:page])
    @favorite_exists = FavoriteJob.where(job: @job, user: current_user) == [] ? false : true
  end

  def show
    @job = Job.latest_jobs.find_by(slug: params[:job_slug])
    @favorite_exists = FavoriteJob.where(job: @job, user: current_user) == [] ? false : true
  end

  private

  def history_action
    history = HistoryJob.where(job_id: @job.id, user_id: current_user.id)
    if history == []
      HistoryJob.create(job_id: @job.id, user_id: current_user.id)
    else
      history.touch_all(:created_at)
    end
    HistoryJob.first.destroy if HistoryJob.count > 20
  end
end
