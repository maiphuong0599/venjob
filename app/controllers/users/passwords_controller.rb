class Users::PasswordsController < Devise::PasswordsController

  protected

  def after_resetting_password_path_for(resource)
    root_path
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    root_path
  end

  def reset_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end
end
