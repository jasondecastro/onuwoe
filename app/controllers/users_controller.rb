class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to new_game_path
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
