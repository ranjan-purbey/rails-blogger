module SessionsHelper
  def login(user, message = "Successfully logged in")
    session[:user_id] = user.id
    flash["success"] = message
    redirect_to request.referrer || root_path
  end
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  def logged_in?
    !current_user.nil?
  end
  def authenticated?
    if logged_in?
      return true
    else
      flash["warning"] = "You must be logged in"
      redirect_to login_path
      return false
    end
  end
  def logout
    session.delete(:user_id)
    @current_user = nil
    flash["success"] = "Successfully logged out"
  end
end
