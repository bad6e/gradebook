require 'rails_helper'

describe StudentCourse do
  subject { create(:student_course) }

  it { should be_valid }

  it { should respond_to(:student_id) }
  it { should respond_to(:course_id) }
  it { should respond_to(:grade) }

  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:course_id) }
  it { should validate_presence_of(:grade) }

  it { should belong_to(:student) }
  it { should belong_to(:course) }

  it { should validate_uniqueness_of(:student_id).scoped_to(:course_id) }

  it { should validate_numericality_of(:grade) }
end
