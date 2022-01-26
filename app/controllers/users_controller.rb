class UsersController < ApplicationController
  def show
    @user = current_user
  end

  private

  def user_params
    params.permit(:user_id)
  end
end
