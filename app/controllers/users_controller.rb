class UsersController < ApplicationController
  def show
    @user = User.new(profile_params)
    @user.save
    flash[:notice] = "Your user account has been created!"
  end


  def profile_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :cv)
  end
end