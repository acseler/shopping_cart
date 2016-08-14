module ShoppingCart
  class AddressForm < Rectify::Form
    attribute :first_name, String
    attribute :last_name, String
    attribute :street, String
    attribute :city, String
    attribute :zip, String
    attribute :phone, String
    attribute :country_id, Fixnum
    attribute :type, Symbol

    validates :first_name, :last_name, :street, :city, :zip, :phone, :country_id,
              presence: true

    validates :zip, numericality: { only_integer: true }, length: { maximum: 5 }
    validates :phone, length: { is: 13 },
              format: { with: /\A\+[0-9]{12}\z/ }

    def assign_type(value)
      self.type = value
      self
    end
  end
end