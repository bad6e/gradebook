class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      route_user(@user)
    else
      flash.now[:errors] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :email,
                                   :type,
                                   :password,
                                   :password_confirmation)
    end
end
