class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  include SessionsHelper
  include ApplicationHelper

  private

    def set_type
      @type = type
    end

    def type
      params[:type]
    end

    def set_user_type
      @user = type_class.find(params[:id])
    end

    def type_class
      type.constantize
    end

    def list_of_user_types
      {
        'student?' => student?,
        'teacher?' => teacher?,
        'admin?' => admin?
      }
    end

    def require_user_type(type)
      render file: '/public/403' unless list_of_user_types[type]
    end

    def verify_current_user
      unless current_user
        render status: 401, json: {
          error: 'Must login for information.'
        }
      end
    end
end
