class Course < ActiveRecord::Base
  belongs_to :semester
  belongs_to :teacher, class_name: "User"

  validates :name, :description,
    presence: true
end
