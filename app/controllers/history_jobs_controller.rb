class HistoryJobsController < ApplicationController
  def show
    @histories = HistoryJob.order('created_at DESC')
  end
end
