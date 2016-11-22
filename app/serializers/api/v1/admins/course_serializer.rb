class Api::V1::Admins::CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :students, serializer: Api::V1::Admins::StudentSerializer
end
