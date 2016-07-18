module ShoppingCart
  class OrderItem < ActiveRecord::Base
    belongs_to :book, class_name: ShoppingCart.book_class
    belongs_to :order
    validates :price, :quantity, presence: true

    def self.take_item(attr)
      find_by(attr)
    end

    def update_book_stock
      book.update(stock: book.stock - quantity, sells: book.sells + quantity)
    end
  end
end
