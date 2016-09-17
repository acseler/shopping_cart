module ShoppingCart
  module CustomersHelper
    ADDRESS_FIELDS = %i(first_name last_name street city zip phone)

    def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

    def draw_address(address_name, form)
      result = ''
      addr = assign_address(address_name, form)
      ADDRESS_FIELDS.each do |field|
        result << address_text_field(field, form, addr)
        result << select_checkout(form, addr) if field == :city
      end
      result.html_safe
    end

    private

    def assign_address(address_name, form)
      address = @order.send(address_name)
      return @order.send(address_name) if address
      @order.send("#{address_name}=", ShoppingCart::Address.create)
    end

    def for_merge(field, form, address)
      attributes = {placeholder: t(field)}
      attributes[:value] = address.send(field) if form
      attributes
    end

    def address_text_field(field, form, address)
      options = {class: 'block'}.merge(for_merge(field, form, address))
      form.text_field(field, options)
    end

    def select_checkout(form, address)
      form.collection_select(:country_id,
                             @address_presenter.countries, :id, :name,
                             select_options(address),
                             class: 'block')
    end

    def selected_country(address)
      lambda { |country| country == address.country }
    end

    def select_options(address)
      {selected: selected_country(address), include_blank: t(:please_select)}
    end
  end
end