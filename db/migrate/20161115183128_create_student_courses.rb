class CreateStudentCourses < ActiveRecord::Migration
  def change
    create_table :student_courses do |t|
      t.references :student, index: true
      t.references :course, index: true

      t.timestamps null: false
    end
  end
end
