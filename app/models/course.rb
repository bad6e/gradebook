class Course < ActiveRecord::Base
  belongs_to :semester
  belongs_to :teacher, class_name: "User"

  has_many :student_courses
  has_many :students, through: :student_courses

  validates :name, :description, :teacher_id, :semester_id,
    presence: true
end
