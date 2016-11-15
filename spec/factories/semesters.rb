FactoryGirl.define do
  factory :semester do
    begin_date { Date.today }
    end_date { Date.today + 3.months }
  end
end
