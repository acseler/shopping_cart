FactoryGirl.define do
  factory :delivery, class: 'ShoppingCart::Delivery' do
    company { FFaker::Company.name }
    option { FFaker::Company.position }
    price { FFaker.numerify('#.##') }
  end
end