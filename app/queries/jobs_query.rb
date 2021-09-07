class JobsQuery
  def initialize(jobs = FavoriteJob, histories = HistoryJob)
    @jobs = jobs.includes(job: %i[cities cities_jobs])
    @histories = histories.includes(job: %i[cities cities_jobs])
  end

  def find_favorite(params, current_user)
    @jobs.where(job: Job.find(params[:job_id]), user: current_user)
  end

  def find_favorite_slug(params, current_user)
    @jobs.where(job: Job.find(params[:job_slug]), user: current_user)
  end

  def order_favorite(current_user)
    @jobs.where(user: current_user).order('favorite_jobs.created_at DESC')
  end

  def order_history(current_user)
    @histories.where(user: current_user).order('history_jobs.created_at DESC')
  end

  def find_history(params, current_user)
    @histories.where(job: Job.find(params[:job_slug]), user: current_user)
  end
end