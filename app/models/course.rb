class Course < ActiveRecord::Base
  belongs_to :semester
  belongs_to :teacher
end
