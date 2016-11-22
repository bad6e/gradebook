class Api::V1::Students::CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  belongs_to :semester
  attribute :student_courses

  def student_courses
    ActiveModelSerializers::SerializableResource.new(object.student_courses.where(student_id: @instance_options[:current_user].id),
                                                     each_serializer: Api::V1::Students::StudentCourseSerializer,
                                                     caller_id: object.id,
                                                     current_user: @instance_options[:current_user])
  end
end
