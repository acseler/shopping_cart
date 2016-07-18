require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  %i(price quantity).each do |symb|
    it { should have_db_column(symb) }
    it { should validate_presence_of(symb) }
  end

  %i(book order).each do |symb|
    it { should belong_to(symb) }
  end

  it 'has valid factory' do
    expect(FactoryGirl.build(:order_item)).to be_valid
  end
end