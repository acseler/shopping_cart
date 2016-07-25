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
        result << country_select(form, addr) if field == :city
      end
      result.html_safe
    end

    def draw_non_social_fields
      return '' if current_user.provider
      render 'customers/non_social_fields'
    end

    private

    def assign_address(address_name, form)
      form ? address_checkout(address_name) : address_settings(address_name)
    end

    def address_settings(addr_name)
      @presenter.customer.send(addr_name)
    end

    def address_checkout(addr_name)
      @order.send(addr_name) || @address_presenter.customer.send(addr_name)
    end

    def for_merge(field, form, address)
      attributes = {placeholder: field}
      attributes[:value] = address.send(field) if form
      attributes
    end

    def address_text_field(field, form, address)
      options = {class: 'form-control'}.merge(for_merge(field, form, address))
      if form
        checkout_field(form, field, options)
      else
        settings_field(field, options, address)
      end
    end

    def settings_field(field, opt, address)
      text_field_tag(field, address.send(field), opt)
    end

    def checkout_field(form, field, opt)
      form.text_field(field, opt)
    end

    def country_select(form, address)
      form ? select_checkout(form, address) : select_settings(address)
    end

    def select_checkout(form, address)
      form.collection_select(:country_id,
                             @address_presenter.countries, :id, :name,
                             select_options(address),
                             class: 'form-control')
    end

    def select_settings(address)
      collection_select(nil, :country_id,
                        @presenter.countries, :id, :name,
                        select_options(address),
                        class: 'form-control')
    end

    def selected_country(address)
      lambda { |country| country == address.country }
    end

    def select_options(address)
      {selected: selected_country(address), include_blank: 'Please Select'}
    end
  end
end