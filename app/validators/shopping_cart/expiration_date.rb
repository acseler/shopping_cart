module ShoppingCart
  class ExpirationDate < ActiveModel::Validator
    def validate(record)
      unless exp_date_presence(record)
        if check_date(record)
          record.errors[:expiraton_date] << I18n.t(:wrong_exp_date)
        end
      end
    end

    private

    def exp_date_presence(record)
      record.exp_month.blank? && record.exp_year.blank?
    end

    def check_date(record)
      Time.new(record.exp_year, record.exp_month) < Time.now
    end
  end
end