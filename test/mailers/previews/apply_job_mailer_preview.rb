# Preview all emails at http://localhost:3000/rails/mailers/apply_job_mailer
class ApplyJobMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/apply_job_mailer/create_apply
  def create_apply
    ApplyJobMailer.create_apply
  end

end
