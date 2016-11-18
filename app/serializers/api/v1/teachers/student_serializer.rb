class Api::V1::Teachers::StudentSerializer < ActiveModel::Serializer
  attributes :full_name, :grade

  def grade
    object.student_courses.find_by(id: @instance_options[:caller_id]).grade
  end
end