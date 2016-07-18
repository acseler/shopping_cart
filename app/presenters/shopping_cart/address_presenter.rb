module ShoppingCart
  class AddressPresenter < Rectify::Presenter
    attribute :countries, Country::ActiveRecord_Relation
    attribute :customer, Customer
    attribute :order, Order
  end
end