FactoryGirl.define do
  factory :course do
    name { Faker::Company.catch_phrase }
    description { Faker::Company.bs }
    semester_id { FactoryGirl.create(:semester).id }
    teacher_id { FactoryGirl.create(:teacher).id }
  end
end