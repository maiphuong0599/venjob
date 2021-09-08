class FavoriteQuery
  def initialize(favorites = FavoriteJob)
    @favorites = favorites.includes(job: %i[cities cities_jobs])
  end

  def find_favorite(params, current_user)
    @favorites.find_by(job: Job.find(params[:job_id]), user: current_user)
  end

  def find_favorite_slug(params, current_user)
    @favorites.find_by(job: Job.find(params[:job_slug]), user: current_user)
  end

  def order_favorite(current_user)
    @favorites.where(user: current_user).order('favorite_jobs.created_at DESC')
  end
end