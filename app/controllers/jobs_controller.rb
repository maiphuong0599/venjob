class JobsController < ApplicationController
  include ApplicationHelper

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
    @job = Job.find_by(slug: params[:job_slug]) or not_found
  end

  def search
    @keyword = job_params[:search].gsub!(/[^[:alnum:]]/, ' ')
    solr = RSolr.connect url: 'http://localhost:8983/solr/VeNJOB'
    response = solr.get 'select', params: {
      q: "city: #{@keyword}* or title: #{@keyword}* or industry: #{@keyword}* or company: #{@keyword}*",
      start: 0,
      rows: 2_147_483_647
    }
    result = response['response']['docs']
    @result_search = Kaminari.paginate_array(result).page(params[:page])
    @total = result.count
  end

  private

  def history_action
    history = history_query.find_history(job_params, current_user)
    if history.nil?
      HistoryJob.create(job: Job.find(params[:job_slug]), user: current_user)
    else
      history.touch(:updated_at)
    end
    HistoryJob.first.destroy if HistoryJob.count > HistoryJob::LIMIT_HISTORY
  end

  def job_params
    params.permit(:job_slug, :search)
  end

  def history_query
    @history_query ||= HistoryQuery.new
  end
end
