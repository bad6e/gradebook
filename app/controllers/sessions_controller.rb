class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: user_params[:email])
    if valid(user)
      log_in(user)
      route_user(user)
    else
      render :new
      flash[:errors] = "Incorrect Login"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def auth_failure
    redirect_to root_path
  end

  private

    def user_params
      params.require(:login).permit(:email, :password)
    end

    def route_user(user)
      if user.type == 'Admin'
        redirect_to admin_path(user)
      elsif user.type == 'Teacher'
        redirect_to teacher_path(user)
      elsif user.type == 'Student'
        redirect_to student_path(user)
      end
    end
end