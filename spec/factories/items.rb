FactoryBot.define do
  factory :item do
    title       { Faker::Food.unique.dish }
    description { Faker::Food.description }
    price       { Faker::Number.decimal(l_digits: 2) }
  end
end

