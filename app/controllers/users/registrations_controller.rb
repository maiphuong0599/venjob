class Users::RegistrationsController < Devise::RegistrationsController 
  def show
  end

  private

  def after_update_path_for(resource)
    my_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    register_2_path
  end
end
