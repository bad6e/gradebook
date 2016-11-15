class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.references :semester, index: true, foreign_key: true
      t.references :teacher, index: true

      t.timestamps null: false
    end
  end
end
