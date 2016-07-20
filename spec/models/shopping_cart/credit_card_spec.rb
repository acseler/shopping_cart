require 'rails_helper'

module ShoppingCart
  RSpec.describe ShoppingCart::CreditCard, type: :model do

    %i(number exp_month exp_year code).each do |symb|
      it { should have_db_column(symb) }
      it { should validate_presence_of(symb) }
    end

    it 'has valid factory' do
      expect(FactoryGirl.build(:credit_card)).to be_valid
    end
  end
end