class TopController < ApplicationController
  def home
    @jobs = Job.latest_jobs.limit(Job::LATEST_JOB_NUMBER)
    @cities = City.top_cities
    @industries = Industry.top_industries
    @total_job = Job.count
  end
end