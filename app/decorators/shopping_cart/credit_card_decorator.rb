module ShoppingCart
  class CreditCardDecorator < Draper::Decorator
    delegate_all

    def exp_date
      "#{object.exp_month}/#{object.exp_year}"
    end

    def hide_card_number
      "** ** ** #{object.number.slice(8..11)}"
    end
  end
end