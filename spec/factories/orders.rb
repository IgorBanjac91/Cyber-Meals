FactoryBot.define do
  factory :order do
    user
    status { "new" }
  end

end

def orders_with_order_items(order_items_count: 4)
  FactoryBot.create(:order) do |order|
    FactoryBot.create_list(:order_item, order_items_count, order: order)
  end
end
