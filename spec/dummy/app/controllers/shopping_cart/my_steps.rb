module ShoppingCart::MySteps
  def my_step_edit
    my_step = @order.my_step || ShoppingCart::MyStep.new
    @my_step_presenter = ShoppingCart::MyStepPresenter.new(order: @order,
                                                           my_step: my_step)
                             .attach_controller(self)
  end

  def my_step
    form = ShoppingCart::MyStepForm.from_params(params)
    form.order = @order
    ShoppingCart::AddMyStep.call(form) do
      on(:ok) { redirect_to payment_order_path }
      on(:invalid) { redirect_to main_app.my_step_order_path }
    end
  end
end
