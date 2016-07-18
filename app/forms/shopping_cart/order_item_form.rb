module ShoppingCart
  class OrderItemForm < Rectify::Form
    attribute :price, Float
    attribute :quantity, Fixnum
    attribute :book_id, Fixnum
    attribute :order, Order

    validates :price, :quantity, :book_id, presence: true
    validates :quantity, numericality: {greater_than: 0}
  end
end