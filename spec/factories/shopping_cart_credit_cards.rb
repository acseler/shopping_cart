FactoryGirl.define do
  factory :credit_card, class: 'ShoppingCart::CreditCard' do
    number '1111111111111111'
    exp_month 1
    exp_year { (Time.now + 2.years).year }
    code 1234
  end
end
