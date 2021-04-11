FactoryBot.define do
  factory :order_address do
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city { Gimei.city }
    block { Gimei.town }
    building { Gimei.town }
    phone { Faker::Number.within(range: 0..99_999_999_999).to_s }
    token { "tok_#{Faker::Lorem.characters(number: 28)}" }
  end
end
