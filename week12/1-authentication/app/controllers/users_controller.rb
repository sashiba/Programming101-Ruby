class UsersController < ApplicationController
  before_action :require_login, only: [:show]
  before_action :correct_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome"
      redirect_to @user
    else
      flash.now[:notice] = "Greshka we"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def require_login
    unless logged_in?
      flash[:danger] = "You must be logged in"
      redirect_to signin_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:danger] = "No permission"
      redirect_to(root_url)
    end
  end
end
