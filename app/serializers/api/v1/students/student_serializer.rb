class Api::V1::Students::StudentSerializer < ActiveModel::Serializer
  attribute :grade, if: :current_user_present?
  attribute :full_name, if: :current_user_present?
  attribute :id, if: :current_user_present?

  def current_user_present?
    @instance_options && @instance_options[:current_user] && @instance_options[:current_user].id == object.id
  end

  def full_name
    object.full_name
  end

  def grade
    object.student_courses.find_by(id: @instance_options[:caller_id]).grade
  end
end
