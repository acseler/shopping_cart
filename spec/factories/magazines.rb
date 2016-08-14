FactoryGirl.define do
  factory :magazine do
    title { FFaker::CheesyLingo.title }
    price { FFaker.numerify('##.#') }
  end
end