module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def valid(user)
    user && user.authenticate(user_params[:password])
  end

  def log_out
    session[:user_id] = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    current_user && current_user.type == 'Admin'
  end

  def teacher?
    current_user && current_user.type == 'Teacher'
  end

  def student?
    current_user && current_user.type == 'Student'
  end

  def verify_user_in_params_matches_current_user
    if params.except(:id).empty? || current_user.id != params[:id].to_i
      render file: '/public/403'
    end
  end

  def render_path(type, current_user)
    eval("#{type.downcase}_path(current_user)")
  end

  def route_user(type, user)
    redirect_to eval("#{type.downcase}_path(user)")
  end
end
