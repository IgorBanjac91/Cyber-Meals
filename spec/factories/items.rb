FactoryBot.define do
  factory :item do
    title            { "Carbonara" }
    description      { "Spaghetti pasta, with bacon and eggs" }
    price            { 7.50 }
    preparation_time { 12 }
    categories       { [create(:random_category)] }
    sale
  end

  factory :random_item, class: Item do
    sequence(:title) { |n| Faker::Food.dish + "#{n}" }
    description      { Faker::Food.description }
    price            { Faker::Number.decimal(l_digits: 2) }
    preparation_time { 12 }
    categories       { [create(:random_category)] }
    sale
  end

  trait :retired do 
    retired { true }
  end
end

