FactoryBot.define do
  factory :item do
    title       { "Carbonara" }
    description { "Spaghetti pasta, with bacon and eggs" }
    price       { 7.50 }
  end

  factory :random_item, class: Item do
    title       { Faker::Food.dish + "#{rand(1..1000)}" }
    description { Faker::Food.description }
    price       { Faker::Number.decimal(l_digits: 2) }
  end
end

