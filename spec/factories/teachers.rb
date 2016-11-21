FactoryGirl.define do
  factory :teacher do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password '12345678'
    password_confirmation '12345678'
    type { 'Teacher' }
  end
end
