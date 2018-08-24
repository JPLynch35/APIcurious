class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(user_auth)
      session[:user_id] = user.id 
      redirect_to user_path(user)
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private
  
  def user_auth
    request.env["omniauth.auth"]
  end
end
