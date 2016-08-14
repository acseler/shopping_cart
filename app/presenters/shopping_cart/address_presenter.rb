module ShoppingCart
  class AddressPresenter < Rectify::Presenter
    attribute :countries, Country::ActiveRecord_Relation
    attribute :customer, User
    attribute :order, Order
  end
end