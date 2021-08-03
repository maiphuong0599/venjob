class JobsController < ApplicationController
  def show
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
end