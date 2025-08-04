class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      cookies.signed[:user_id] = user.id  # For ActionCable authentication
      flash[:success] = "You have successfully logged in"
      redirect_to chat_path
    else
      flash.now[:error] = "There was something wrong with your login details"
      @user = User.new
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:user_id)  # Clear ActionCable cookie
    flash[:success] = "You have successfully logged out"
    redirect_to root_path
  end
  
  private
  
  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to chat_path
    end
  end
end
