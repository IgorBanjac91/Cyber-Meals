FactoryBot.define do
  factory :item do
    title       { Faker::Food.dish }
    description { Faker::Food.description }
    price       { Faker::Number.dicimal(l_digits: 2) }
    order
  end
end
