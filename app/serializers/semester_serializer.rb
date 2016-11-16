class SemesterSerializer < ActiveModel::Serializer
  attributes :id, :begin_date, :end_date
end