class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    session.delete(:apply_job_ids) if session[:apply_job_ids].present?
    hash_condition = { email: params[:email],
                       cities: { id: params[:city_id] },
                       industries: { id: params[:industry_id] } }
    remove_blank_value = deep_compact(hash_condition)
    @applied_jobs = applied_jobs_query.query_date(apply_params).where(remove_blank_value).page(params[:page])
    session[:apply_job_ids] = @applied_jobs.map(&:id)
  end

  def export
    apply_job = ApplyJob.find(session[:apply_job_id])
    csv = ExportCsvService.new(apply_job, Admin::CSV_ATTRIBUTES)
    respond_to do |format|
      format.html
      format.csv { send_data csv.perform, filename: "Applies_Jobs-#{Date.today}.csv" }
    end
  end

  private

  def apply_params
    params.permit(:email, :city_id, :industry_id, :start_date, :end_date)
  end

  def applied_jobs_query
    @applied_jobs_query ||= AppliedQuery.new
  end

  def deep_compact(hash_condition)
    hash_condition.each { |_, v| deep_compact(v) if v.is_a? Hash }.reject! { |_, v| v.nil? || v.blank? }
  end
end