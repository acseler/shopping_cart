FactoryGirl.define do
  factory :delivery do
    company { FFaker::Company.name }
    option { FFaker::Company.position }
    price { FFaker.numerify('#.##') }
  end
end
