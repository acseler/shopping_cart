class Customer < ActiveRecord::Base
  has_many :orders, class_name: 'ShoppingCart::Order', as: :customer
  belongs_to :user
  belongs_to :billing_address, class_name: 'Address', foreign_key: 'billing_address_id'
  belongs_to :shipping_address, class_name: 'Address', foreign_key: 'shipping_address_id'
  delegate :order_in_proggress, to: :orders
  delegate :in_queue, to: :orders, prefix: true
  delegate :in_delivery, to: :orders, prefix: true
  delegate :delivered, to: :orders, prefix: true
end
