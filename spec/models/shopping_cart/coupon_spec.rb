require 'rails_helper'

RSpec.describe Coupon, type: :model do

  %i(per_cent code).each do |symb|
    it { should have_db_column(symb) }
    it { should validate_presence_of(symb) }
  end

  it { should validate_uniqueness_of(:code) }

  it 'has valid factory' do
    expect(FactoryGirl.build(:coupon)).to be_valid
  end
end
