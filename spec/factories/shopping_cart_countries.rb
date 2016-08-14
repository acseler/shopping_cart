FactoryGirl.define do
  factory :country, class: 'ShoppingCart::Country' do
    sequence(:name) { |n| "Country #{n}" }
  end
end
