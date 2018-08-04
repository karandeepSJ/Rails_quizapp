class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update, :show]
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if logged_in?
      redirect_to @user
    end
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def checklogged
      if logged_in?
        if current_user.admin
          log_out
          render :js => "window.location = '/login'"
        else
          render :js => "window.location = 'users/#{current_user.id}'"
        end
      end
  end 

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to current_user unless @user == current_user
    end
end
