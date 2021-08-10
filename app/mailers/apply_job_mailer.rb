class ApplyJobMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.apply_job_mailer.create_apply.subject
  #
  def create_apply
    @apply_job = params[:apply_job]
    #@name = params[:name]
    # @email = params[:email]
    # @cv = params[:email]
    mail to: @apply_job.email, subject: 'CONFIRM INFORMATION'
  end

  # def create_apply
  #   @greeting = "Hi"

  #   mail to: "to@example.org"
  # end
end
