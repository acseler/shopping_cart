module ShoppingCart
  class PaymentPresenter < Rectify::Presenter
    attribute :credit_card, CreditCard

    def month_select(form)
      form.collection_select(:exp_month, months, :first, :last, month_options,
                             class: 'form-control')
    end

    def month_options
      {selected: credit_card.exp_month, include_blank: 'Please Select'}
    end

    def year_select(form)
      form.select(:exp_year, options_for_select(years, credit_card.exp_year),
                  {include_blank: 'Please Select'}, class: 'form-control')
    end

    def months
      (1..12).to_a.map { |m| [m, Date::MONTHNAMES[m]] }
    end

    def years
      (Time.now.year..2050).to_a.map { |i| i }
    end
  end
end
