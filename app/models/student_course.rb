class StudentCourse < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  validates :student_id, :course_id, :grade,
    presence: true

  validates :student_id,
    uniqueness: { scope: :course_id }

  validates :grade,
    numericality: true
end
