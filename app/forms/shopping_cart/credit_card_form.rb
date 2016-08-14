module ShoppingCart
  class CreditCardForm < Rectify::Form
    include ActiveModel::Validations
    attribute :number, String
    attribute :exp_month, Fixnum
    attribute :exp_year, Fixnum
    attribute :code, Fixnum
    attribute :order, Order

    validates :number, :exp_month, :exp_year, :code, presence: true
    validates :number, format: { with: /\A[0-9]{16}\z/ }, length: { is: 16 }
    validates :code, length: {in: (3..4) }, numericality: true
    validates_with ExpirationDate
  end
end