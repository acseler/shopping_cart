FactoryGirl.define do
  factory :customer do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    billing_address { FactoryGirl.create(:address, first_name: first_name,
                                         last_name: last_name) }
    shipping_address { FactoryGirl.create(:address, first_name: first_name,
                                          last_name: last_name) }
    user { FactoryGirl.create(:user) }

    after(:create) do |customer|
      customer.orders << FactoryGirl.create(:order,
                                            total_price: 100,
                                            shipping_price: 20,
                                            sub_total_price: 80)
    end
  end
end