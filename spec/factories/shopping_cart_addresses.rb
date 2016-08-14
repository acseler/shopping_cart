FactoryGirl.define do
  factory :address, class: 'ShoppingCart::Address' do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    street { FFaker::Address.street_address }
    city { FFaker::Address.city }
    zip { FFaker.numerify('#####') }
    phone '+380551234567'
    country { FactoryGirl.create(:country) }
  end
end
