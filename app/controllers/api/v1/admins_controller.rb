class Api::V1::AdminsController < ApplicationController
  respond_to :json
  # before_action :verify_user_in_params_matches_current_user, only: [:show]

  def grades
    @grade = Course.preload(:student_courses).find(admin_params[:id])
    respond_with @grade.student_courses.pluck(:grade)
  end

  def enrollment_counts
    @semester = Semester.preload(:courses).find(admin_params[:id])
    respond_with @semester.courses, each_serializer: Api::V1::Admins::CourseSerializer
  end

  private

    def admin_params
      params.permit(:id)
    end

    def verify_user_in_params_matches_current_user
      if current_user.id != admin_params[:id].to_i
        render status: 401, json: {
          error: "Admins only."
        }
      end
    end
end