FactoryGirl.define do
  factory :semester do
    begin_date { Date.today + Random.rand(1111).days}
    end_date { Date.today + Random.rand(1111).months }
  end
end
