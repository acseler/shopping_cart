FactoryGirl.define do
  factory :coupon, class: 'ShoppingCart::Coupon' do
    per_cent { rand(1..100) }
    code { FFaker::CheesyLingo.word }
  end
end
