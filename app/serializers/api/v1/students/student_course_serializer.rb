class Api::V1::Students::StudentCourseSerializer < ActiveModel::Serializer
  attribute :students, if: :current_student_present?

  def current_student_present?
    object.student_id == @instance_options[:current_user].id
  end

  def students
    ActiveModelSerializers::SerializableResource.new(object.student,
                                                     each_serializer: Api::V1::Students::StudentSerializer,
                                                     caller_id: object.id,
                                                     current_user: @instance_options[:current_user])
  end
end
