class Api::V1::TeachersController < ApplicationController
  respond_to :json

  before_action :verify_user_in_params_matches_current_user, only: [:show]

  def show
    courses = Teacher.find(params[:id]).courses
    respond_with courses
  end

  private

    def teacher_params
      params.permit(:id)
    end

    def verify_user_in_params_matches_current_user
      if teacher_params.except(:id).empty? || current_user.id != teacher_params[:id].to_i
         render status: 401, json: {
          error: "Teachers can only see their own classes"
        }
      end
    end
end
