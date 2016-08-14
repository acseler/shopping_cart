module ShoppingCart
  class Order < ActiveRecord::Base
    include AASM

    aasm column: :state do
      state :in_progress, initial: true
      state :in_queue
      state :in_delivery
      state :delivered
      state :canceled

      event :queue do
        transitions from: :in_progress, to: :in_queue
      end

      event :deliver do
        transitions from: :in_queue, to: :in_delivery
      end

      event :shipped do
        transitions from: :in_delivery, to: :delivered
      end

      event :cancel do
        transitions from: :in_queue, to: :canceled
      end
    end
    STATE_ARRAY = %i(in_progress
                   in_queue
                   in_delivery
                   delivered
                   canceled)

    has_many :order_items, dependent: :delete_all
    accepts_nested_attributes_for :order_items
    belongs_to :billing_address, class_name: 'ShoppingCart::Address',
               foreign_key: 'billing_address_id'
    belongs_to :shipping_address, class_name: 'ShoppingCart::Address',
               foreign_key: 'shipping_address_id'
    belongs_to :customer, polymorphic: true
    belongs_to :delivery
    belongs_to :credit_card
    belongs_to :coupon

    scope :in_progress, -> { where(state: 'in_progress') }

    delegate :take_item, to: :order_items

    def state_enum
      STATE_ARRAY
    end

    def calculate_total
      update(sub_total_price: items_sum, total_price: total_sum)
    end

    private

    def items_sum
      order_items.sum('price * quantity') * discount
    end

    def total_sum
      shipping_price + items_sum
    end

    def discount
      coupon_exists? ? (100.0 - coupon.per_cent) / 100.0 : 1
    end

    def coupon_exists?
      !coupon.nil?
    end
  end
end
