class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.date :begin_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
