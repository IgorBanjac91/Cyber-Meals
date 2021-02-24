FactoryBot.define do
  factory :item do
    title       { Faker::Food.dish + "#{rand(1..1000)}" }
    description { Faker::Food.description }
    price       { Faker::Number.decimal(l_digits: 2) }
  end
end

