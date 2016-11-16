class AddGradeToStudentCourses < ActiveRecord::Migration
  def change
    add_column :student_courses, :grade, :float, default: 0
  end
end
