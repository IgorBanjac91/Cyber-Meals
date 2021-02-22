FactoryBot.define do
  factory :category do
    name { "Dinner" }
  end

  trait :desserts do 
    name { "Desserts"}
  end

  trait :main do 
    name { "Main" }
  end
 
  trait :lactose_free do 
    name { "Lactose Free" }
  end
end

def category_with_items(items_count: 10)
  FactoryBot.create(:category) do |category|
    FactoryBot.create_list(:item, items_count, categories: [category] )
  end
end