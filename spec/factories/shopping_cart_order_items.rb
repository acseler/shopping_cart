FactoryGirl.define do
  factory :order_item, class: 'ShoppingCart::OrderItem'  do
    price { book.price }
    quantity { rand(1..10) }
    book { FactoryGirl.create(:book) }
  end
end
