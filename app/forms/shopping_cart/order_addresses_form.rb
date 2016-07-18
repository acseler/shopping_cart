module ShoppingCart
  class OrderAddressesForm < Rectify::Form
    attribute :billing_address, AddressForm
    attribute :shipping_address, AddressForm
    attribute :use_billing_address, Hash
    attribute :order, Order
    attribute :errors, Array
  end
end