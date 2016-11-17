class StudentCourseSerializer < ActiveModel::Serializer
  attributes :id, :grade, :student_name

  def student_name
    StudentSerializer.new(object.student).attributes
  end
end