class ApplyJobMailer < ApplicationMailer
  def create_apply
    @apply_job = params[:apply_job]
    @job = params[:job]
    mail to: @apply_job.email, subject: 'CONFIRM INFORMATION'
  end
end
