FactoryBot.define do
  factory :menu do
    quantity { 1 }
    percentage { 10 }
    items { [create(:random_item, categories: [create(:category, name: "Appetizer")]), 
            create(:random_item, categories: [create(:category, name: "Main Dish")]), 
            create(:random_item, categories: [create(:category, name: "Dessert")]), 
            create(:random_item, categories: [create(:category, name: "Drink")])]}
    order
    description { self.format_description }
    price { self.calculate_price }

    trait :invalid do 
      items { [create(:random_item, categories: [create(:category, name: "Appetizer")]), 
               create(:random_item, categories: [create(:category, name: "Main Dish")]), 
               create(:random_item, categories: [create(:category, name: "Drink")])]}
    end
  end
end
