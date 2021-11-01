class AppliedQuery
  def initialize(applied_jobs = ApplyJob)
    @applied_jobs = applied_jobs.includes(job: %i[cities cities_jobs industries])
  end

  def order_applied_jobs(current_user)
    @applied_jobs.where(user: current_user).order('apply_jobs.created_at DESC')
  end

  def query_date(params)
    if params[:start_date].present? && params[:end_date].present?
      @applied_jobs.where(created_at: params[:start_date]..params[:end_date])
    elsif params[:start_date].present?
      @applied_jobs.where('apply_jobs.created_at >= ?', params[:start_date].to_date.beginning_of_day)
    elsif params[:end_date].present?
      @applied_jobs.where('apply_jobs.created_at =< ?', params[:end_date].to_date.end_of_day)
    else
      @applied_jobs
    end
  end
end