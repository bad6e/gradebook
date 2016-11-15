class Api::V1::TeachersController < ApplicationController
  respond_to :json

  def show
    courses = Teacher.find(params[:id]).courses
    respond_with courses
  end
end
