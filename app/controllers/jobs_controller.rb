class JobsController < ApplicationController
  def show
    if params[:city_slug].present?
      @city = City.find_by(slug: params[:city_slug])
      @jobs = @city.jobs.order(created_at: :desc).page(params[:page]).per(20)
    elsif params[:industry_slug].present?
      @industry = Industry.find_by(slug: params[:industry_slug])
      @jobs = @industry.jobs.order(created_at: :desc).page(params[:page]).per(20) 
    end
  end
end
