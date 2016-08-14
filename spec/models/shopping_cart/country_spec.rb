require 'rails_helper'

module ShoppingCart
  RSpec.describe Country, type: :model do
    %i(name).each do |symb|
      it { should have_db_column(symb) }
      it { should validate_presence_of(symb) }
    end

    it 'has valid factory' do
      expect(FactoryGirl.build(:country)).to be_valid
    end
  end
end
