class Api::V1::CoursesController < ApplicationController
  respond_to :json

  def index
    respond_with Course.all, each_serializer: Api::V1::Courses::CourseSerializer
  end
end