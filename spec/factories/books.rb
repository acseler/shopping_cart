FactoryGirl.define do
  factory :book do
    title { FFaker::CheesyLingo.title }
    price { FFaker.numerify('##.#') }
  end
end