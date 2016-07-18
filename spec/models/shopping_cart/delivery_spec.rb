require 'rails_helper'

RSpec.describe Delivery, type: :model do

  %i(company option price).each do |symb|
    it { should have_db_column(symb) }
    it { should validate_presence_of(symb) }
  end

  it 'has valid factory' do
    expect(FactoryGirl.build(:delivery)).to be_valid
  end
end
