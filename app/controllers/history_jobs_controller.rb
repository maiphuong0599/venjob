class HistoryJobsController < ApplicationController
  def index
    @histories = history_query.order_history(current_user)
  end

  private

  def history_query
    @history_query ||= HistoryQuery.new
  end
end
