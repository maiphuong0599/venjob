class HistoryJobsController < ApplicationController
  def show
    @histories = JobsQuery.new.order_history(current_user)
  end
end
