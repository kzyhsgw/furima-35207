FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number: rand(1..40)) }
    text { Faker::Lorem.characters(number: rand(1..1000)) }
    category_id { Faker::Number.within(range: 2..11) }
    condition_id { Faker::Number.within(range: 2..3) }
    postage_id { Faker::Number.within(range: 2..3) }
    prefecture_id { Faker::Number.within(range: 2..48) }
    day_id { Faker::Number.within(range: 2..4) }
    price { Faker::Number.within(range: 300..9_999_999).to_s }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
