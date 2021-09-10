class AppliedQuery
  def initialize(applied_jobs = ApplyJob)
    @applied_jobs = applied_jobs.includes(job: %i[cities cities_jobs])
  end

  def order_applied_jobs(current_user)
    @applied_jobs.where(user: current_user).order('apply_jobs.created_at DESC')
  end
end