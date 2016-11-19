class Api::V1::Courses::CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
end