FactoryGirl.define do
  factory :order_item, class: 'ShoppingCart::OrderItem'  do
    price { product.price }
    quantity { rand(1..10) }
    product { FactoryGirl.create(:book) }
  end
end
