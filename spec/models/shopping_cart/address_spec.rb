require 'rails_helper'

module ShoppingCart
  RSpec.describe Address, type: :model do
    %i(
    first_name
    last_name
    street
    city
    zip
    phone
  ).each do |symb|
      it { should have_db_column(symb) }
    end

    it { should belong_to(:country) }

    it 'has valid factory' do
      expect(FactoryGirl.build(:address)).to be_valid
    end
  end
end
