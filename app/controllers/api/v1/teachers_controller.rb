class Api::V1::TeachersController < ApplicationController
  respond_to :json
  before_action :verify_current_user, only: [:show]
  before_action :verify_current_user_is_teacher, only: [:show]
  before_action :verify_user_in_params_matches_current_user, only: [:show]

  def show
    @teacher = Teacher.preload(:courses).find(teacher_params[:id])
    respond_with @teacher.courses.order(:id), each_serializer: Api::V1::Teachers::CourseSerializer
  end

  private

    def teacher_params
      params.permit(:id)
    end

    def verify_current_user_is_teacher
      unless current_user.teacher?
        render status: 401, json: {
          error: 'Teachers Only.'
        }
      end
    end

    def verify_user_in_params_matches_current_user
      if current_user.id != teacher_params[:id].to_i
        render status: 401, json: {
          error: 'Teachers can only see their own classes.'
        }
      end
    end
end
