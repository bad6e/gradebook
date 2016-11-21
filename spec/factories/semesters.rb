FactoryGirl.define do
  factory :semester do
    begin_date { Date.today + Random.rand(1111111111).seconds }
    end_date { Date.today + Random.rand(1111111111).days }
  end
end