class Book < ActiveRecord::Base
  has_many :order_items, dependent: :destroy, as: :book
  validates :title, :price, presence: true
end
