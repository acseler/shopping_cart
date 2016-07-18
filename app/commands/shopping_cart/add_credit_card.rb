module ShoppingCart
  class AddCreditCard < BaseCommand

    def name
      :add_credit_card
    end

    private

    def add_credit_card
      attr = attr_except(:order)
      if card
        card.update(attr)
      else
        create_credit_card(attr)
      end
    end

    def create_credit_card(attr)
      order.credit_card = CreditCard.create(attr)
      order.save
    end

    def card
      order.credit_card
    end
  end
end