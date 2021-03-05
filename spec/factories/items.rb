FactoryBot.define do
  factory :item do
    title       { "Carbonara" }
    description { "Spaghetti pasta, with bacon and eggs" }
    price       { 7.50 }
    categories { |c|[c.association(:random_category)] }
  end

  factory :random_item, class: Item do
    title       { Faker::Food.dish + "#{rand(1..1000)}" }
    description { Faker::Food.description }
    price       { Faker::Number.decimal(l_digits: 2) }
    categories { |c|[c.association(:random_category)] }
  end

  trait :retired do 
    retired { true }
  end
end

