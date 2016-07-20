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
    attribute :customer, Customer

    validates :first_name, :last_name, :street, :city, :zip, :phone, :country_id,
              presence: true

    def assign_type(value)
      self.type = value
      self
    end
  end
end