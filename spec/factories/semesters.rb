FactoryGirl.define do
  factory :semester do
    begin_date { Date.today + Random.rand(111_111_111_1).seconds }
    end_date { Date.today + Random.rand(111_111_111_1).days }
  end
end
