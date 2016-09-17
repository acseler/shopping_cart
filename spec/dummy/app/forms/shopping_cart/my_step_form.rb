module ShoppingCart
  class MyStepForm < Rectify::Form
    attribute :name, String
    attribute :order, ShoppingCart::Order

    validates :name, presence: true
  end
end
