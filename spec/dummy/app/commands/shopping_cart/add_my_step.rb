module ShoppingCart
  class AddMyStep < ShoppingCart::BaseCommand
    def name
      :add_my_step
    end

    private

    def add_my_step
      attr = attr_except(:order)
      order.my_step = MyStep.create(attr)
      order.save
    end
  end
end
