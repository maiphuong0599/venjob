class HistoryQuery
  def initialize(histories = HistoryJob)
    @histories = histories.includes(job: %i[cities cities_jobs])
  end

  def order_history(current_user)
    @histories.where(user: current_user).order('history_jobs.updated_at DESC')
  end

  def find_history(params, current_user)
    @histories.where(job: Job.find(params[:job_slug]), user: current_user)
  end
end