class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to user_blogs_path(current_user)
    end
  end
  def create
    user = User.find_by(username: params[:session][:username])
    if user and user.authenticate(params[:session][:password])
      login user
    else
      flash.now["danger"] = "Wrong credentials"
    end
  end
  def destroy
    logout
  end
end
