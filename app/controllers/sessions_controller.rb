class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by name: params[:name]
    if user.nil? or not user.authenticate params[:password]
      redirect_to :back, notice: "Username and password do not match."
    else
      session[:user_id] = user.id
      redirect_to links_path, notice: "You've logged in."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, notice: "You've logged out."
  end
end