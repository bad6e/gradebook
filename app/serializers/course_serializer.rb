class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  belongs_to :semester
  has_many :student_courses
end