class Api::V1::SemestersController < ApplicationController
  respond_to :json

  def index
    respond_with Semester.all, each_serializer: Api::V1::Semesters::SemesterSerializer
  end
end
