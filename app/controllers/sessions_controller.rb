# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to user_blogs_path(current_user) if logged_in?
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user&.authenticate(params[:session][:password])
      login user
    else
      flash.now[:danger] = 'Wrong credentials'
    end
  end

  def destroy
    if logged_in?
      logout
    else
      redirect_to root_path
    end
  end
end
