FactoryGirl.define do
  factory :book do
    title { FFaker::CheesyLingo.title }
    short_desc { FFaker::CheesyLingo.paragraph(43) }
    full_desc { FFaker::CheesyLingo.paragraph(87) }
    price { FFaker.numerify('##.#') }
  end
end