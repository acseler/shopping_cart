FactoryGirl.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    street { FFaker::Address.street_address }
    city { FFaker::Address.city }
    zip { FFaker::AddressUS.zip_code }
    phone { FFaker::PhoneNumber.phone_number }
    country { FactoryGirl.create(:country) }
  end
end