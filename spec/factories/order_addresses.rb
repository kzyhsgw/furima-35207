FactoryBot.define do
  factory :order_address do
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city { Gimei.city.kanji }
    block { Gimei.town.kanji }
    building { Gimei.town.kanji }
    phone { Faker::Number.leading_zero_number(digits: 11).to_s }
  end
end
