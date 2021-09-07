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
  end

  def show
    @job = Job.latest_jobs.find_by(slug: params[:job_slug])
    @favorite_exists = FavoriteJob.where(job: @job, user: current_user) != []
  end

  private

  def history_action
    history = JobsQuery.new.find_history(job_params, current_user)
    if history == []
      HistoryJob.create(job: Job.find(params[:job_slug]), user: current_user)
    else
      history.touch_all(:created_at)
    end
    HistoryJob.first.destroy if HistoryJob.count > 20
  end

  def job_params
    params.permit(:job_slug)
  end
end
