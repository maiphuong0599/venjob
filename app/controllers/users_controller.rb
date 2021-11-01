class UsersController < ApplicationController
  def show
    @user = User.find(user_params[:user_id])
  end

  private

  def user_params
    params.permit(:user_id)
  end
end
