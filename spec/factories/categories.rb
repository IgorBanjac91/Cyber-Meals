FactoryBot.define do
  factory :category do
    name { "Dinner" }
    sale 
  end

  factory :random_category, class: Category do 
    sequence(:name) { |n| Faker::Cannabis.strain + "#{n}"}
    sale 
  end

  trait :invalid do
    name { " " }
    sale 
  end

  trait :desserts do 
    name { "Desserts"}
    sale 
  end

  trait :main do 
    name { "Main" }
    sale 
  end
 
  trait :lactose_free do 
    name { "Lactose Free" }
    sale 
  end
end



def category_with_items(items_count: 2)
  FactoryBot.create(:category) do |category|
    FactoryBot.create_list(:random_item, items_count, categories: [category] )
  end
end

def desserts_category_with_items(items_count: 3)
  FactoryBot.create(:category, :desserts) do |category|
    FactoryBot.create_list(:random_item, items_count, categories: [category] )
  end
end

def lactose_free_category_with_items(items_count: 3)
  FactoryBot.create(:category, :lactose_free) do |category|
    FactoryBot.create_list(:random_item, items_count, categories: [category] )
  end
end