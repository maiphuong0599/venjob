class JobsController < ApplicationController
  def show
    if params[:city_slug].present?
      @city = City.find_by(slug: params[:city_slug])
      @jobs = @city.jobs.latest_jobs.page(params[:page])
    else
      @industry = Industry.find_by(slug: params[:industry_slug])
      @jobs = @industry.jobs.latest_jobs.page(params[:page])
    end
  end
end