class Api::V1::Teachers::SemesterSerializer < ActiveModel::Serializer
  attributes :id, :begin_date, :end_date, :semester_name

  def semester_name
    "#{object.begin_date} to #{object.end_date}"
  end
end
