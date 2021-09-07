class HistoryJobsController < ApplicationController
  def index
    @histories = job_query.order_history(current_user)
  end

  private

  def job_query
    @job_query ||= HistoryQuery.new
  end
end
