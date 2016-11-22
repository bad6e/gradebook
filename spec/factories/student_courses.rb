FactoryGirl.define do
  factory :student_course do
    student { FactoryGirl.create(:student) }
    course { FactoryGirl.create(:course) }
    grade { [0, 1, 2, 3, 4].sample }
  end
end
