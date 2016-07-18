module ShoppingCart
  class UpdateOrderAddresses < BaseCommand

    def call
      validate_form(:update_fields, valid_addresses?, validation_error_messages)
    end

    private

    def update_fields
      update_billing_address
      update_shipping_address
      order.save
    end

    def update_billing_address
      bill = :billing_address
      attr = attributes(bill)
      if addr = take_address(bill)
        addr.update(attr)
      else
        order.billing_address = Address.create(attr)
      end
    end

    def update_shipping_address
      if addr = take_address(:shipping_address)
        shipping_update_if_exist(addr)
      else
        shipping_update_unless_exist
      end
    end

    def take_address(type)
      order.send(type)
    end

    def shipping_update_if_exist(addr)
      addr.update(attr_for_shipping)
    end

    def shipping_update_unless_exist
      order.shipping_address = Address.create(attr_for_shipping)
    end

    def attr_for_shipping
      if use_billing_address?
        attributes(:billing_address)
      else
        attributes(:shipping_address)
      end
    end

    def attributes(type)
      attr_addr_except(type, 'id', :customer, :type)
    end

    def use_billing_address?
      @form.use_billing_address['check'] == '1'
    end

    # Validation methods

    def valid_addresses?
      form_valid?(:billing_address) && ship_valid?
    end

    def validation_error_messages
      bill = :billing_address
      return flash_hash(bill) unless form_valid?(bill)
      flash_hash(:shipping_address) unless ship_valid?
    end

    def form_valid?(type)
      addr_form(type).valid?
    end

    def ship_valid?
      return true if use_billing_address?
      form_valid?(:shipping_address)
    end

    def flash_hash(type)
      {danger: form_messages(type)}
    end

    def form_messages(type)
      addr_form(type).errors.full_messages
    end

    def addr_form(type)
      @form.send(type)
    end
  end
end
