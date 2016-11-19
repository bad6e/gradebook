class Api::V1::StudentsController < ApplicationController
  respond_to :json
  before_action :verify_current_user, only: [:show]
  before_action :verify_user_in_params_matches_current_user, only: [:show]

  def show
    @student = Student.preload(:courses).find(student_params[:id])
    respond_with @student.courses, each_serializer: Api::V1::Students::CourseSerializer, current_user: current_user
  end

  private

    def student_params
      params.permit(:id)
    end

    def verify_user_in_params_matches_current_user
      if current_user.id != student_params[:id].to_i
         render status: 401, json: {
          error: "Students can only see their own schedule and grades."
        }
      end
    end
end
