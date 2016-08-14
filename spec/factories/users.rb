FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password(8) }

    after(:create) do |user|
      user.orders << FactoryGirl.create(:order,
                                            total_price: 100,
                                            shipping_price: 20,
                                            sub_total_price: 80)
    end
  end
end