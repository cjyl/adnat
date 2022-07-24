class UsersController < ApplicationController
  def update
    user.update(user_params)
    redirect_to organisations_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
