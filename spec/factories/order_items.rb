FactoryBot.define do
  factory :order_item do
    order 
    item 
    quantity  { rand(1..6) }
  end
end
