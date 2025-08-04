class HomeController < ApplicationController

  def index
    redirect_to chat_path if logged_in?
  end
end
