FactoryGirl.define do
  factory :coupon do
    per_cent { rand(1..100) }
    code { FFaker::CheesyLingo.word }
  end
end
