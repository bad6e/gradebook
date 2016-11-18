class Api::V1::Teachers::StudentCourseSerializer < ActiveModel::Serializer
  attributes :students

  def students
    ActiveModelSerializers::SerializableResource.new(object.student,
                                                      each_serializer: Api::V1::Teachers::StudentSerializer,
                                                      caller_id: object.id)
  end
end