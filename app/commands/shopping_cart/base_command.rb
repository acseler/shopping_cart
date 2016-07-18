module ShoppingCart
  class BaseCommand < Rectify::Command
    include CommandsHelper

    def initialize(form)
      @form = form
    end

    def call
      validate_form(name, @form.valid?)
    end

    def name
      raise NoMethodError 'You must define name method for sub class.'
    end
  end
end