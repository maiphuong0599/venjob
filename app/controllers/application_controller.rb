class ApplicationController < ActionController::Base
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cv])
  end

  def after_sign_up_path_for(resource)
    profiles_path(resource)
  end
end
