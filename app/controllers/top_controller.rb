class TopController < ApplicationController
  def home
    @jobs = Job.latest_jobs
    @cities = City.top_cities
    @industries = Industry.top_industries
    @total_job = Job.all.count
  end
end
