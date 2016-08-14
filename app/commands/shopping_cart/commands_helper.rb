module ShoppingCart
  module CommandsHelper
    def attr_except(*exceptions)
      @form.attributes.except(*exceptions)
    end

    def attr_addr_except(type, *exceptions)
      @form.send(type).attributes.except(*exceptions)
    end

    def validate_form(method, validation, custom_errors = err_message)
      validation ? do_staff(method) : invalid(custom_errors)
    end

    def invalid(msg)
      add_msg_to_flash(msg) if msg
      broadcast(:invalid)
    end

    def add_msg_to_flash(msg)
      key = msg.keys.first
      flash[key] = msg[key]
    end

    def err_message
      {danger: @form.errors.full_messages}
    end

    def do_staff(method)
      transaction do
        send(method)
      end
      broadcast(:ok)
    end

    def user
      @form.user
    end

    def order
      @form.order
    end
  end
end