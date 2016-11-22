class Api::V1::Teachers::CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  belongs_to :semester
  has_many :student_courses, serializer: Api::V1::Teachers::StudentCourseSerializer
end
