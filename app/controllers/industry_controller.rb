class IndustryController < ApplicationController
  def list_industry
    @industry_list = Industry.industry_list
  end

  def show 
    @industry = Industry.find(params[:slug])
    @jobs = @industry.jobs.order(created_at: :desc).page(params[:page]).per(20)
  end
end