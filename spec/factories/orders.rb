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

def cancelled_orders_with_order_items(order_items_count: 4)
  FactoryBot.create(:order, status: "cancelled") do |order|
    FactoryBot.create_list(:order_item, order_items_count, order: order)
  end
end

def completed_orders_with_order_items(order_items_count: 4)
  FactoryBot.create(:order, status: "ordered") do |order|
    FactoryBot.create_list(:order_item, order_items_count, order: order)
  end
end

def ordered_orders_with_order_items(order_items_count: 4)
  FactoryBot.create(:order, status: "completed") do |order|
    FactoryBot.create_list(:order_item, order_items_count, order: order)
  end
end
