class SessionsController < ApplicationController
  before_action :only_render_if_no_current_user, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: user_params[:email])
    if valid(user)
      log_in(user)
      route_user(user)
    else
      flash.now[:errors] = 'Invalid Login'
      render :new
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
      params.require(:login).permit(:email,
                                    :password)
    end
end
