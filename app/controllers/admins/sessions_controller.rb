# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # def after_sign_in_path_for(resource)
  #   if session[:user_return_to] == nil
  #     admin_applies_path
  #   else
  #     super
  #   end
  # end
  # def after_sign_in_path_for(resource)
  #   admin_applies_path(resource)
  # end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
