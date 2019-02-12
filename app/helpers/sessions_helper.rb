# frozen_string_literal: true

module SessionsHelper
  def login(user, message = 'Successfully logged in')
    session[:user_id] = user.id
    flash[:success] = message
    redirect_to params[:referrer] || root_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    flash[:success] = 'Successfully logged out'
    redirect_to request.referrer || root_path
  end
end
