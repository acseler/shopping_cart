FactoryGirl.define do
  factory :order, class: 'ShoppingCart::Order' do
    total_price { FFaker.numerify('###.##') }
    sub_total_price { FFaker.numerify('##.##') }
    shipping_price { FFaker.numerify('##.##') }
    completed_date { FFaker::Time.date }

    trait :in_queue do
      state 'in_queue'
    end

    trait :in_delivery do
      state 'in_delivery'
    end

    trait :delivered do
      state 'delivered'
    end

    billing_address { FactoryGirl.create(:address) }
    shipping_address { FactoryGirl.create(:address) }
    delivery { FactoryGirl.create(:delivery, price: 20) }
    after(:create) do |order|
      order.order_items << FactoryGirl.create(:order_item, price: 80, quantity: 1)
    end
  end
end
