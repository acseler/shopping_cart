module ShoppingCart
  class MyStepPresenter < Rectify::Presenter
    attribute :order, ShoppingCart::Order
    attribute :my_step, ShoppingCart::MyStep
  end
end