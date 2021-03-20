FactoryBot.define do
  factory :order do
    status { "new" }
  
    trait :cancelled do 
      status { "cancelled" }
    end
    trait :completed do 
      status { "completed" }
    end
    trait :ordered do 
      status { "ordered" }
      preparation_time { 12 } # When an order is status "ordered" it has to have a prepartion time
    end
  
    trait :paid do 
      status { "paid" }
    end
  
    trait :with_user do 
      user 
    end
  
    trait :with_random_user do 
      user { create(:random_user) }
    end
  
    factory :cancelled_order_with_random_user, traits: [:cancelled, :with_random_user]
    factory :completed_order_with_random_user, traits: [:completed, :with_random_user]
    factory :ordered_order_with_random_user,   traits: [:ordered, :with_random_user]
    factory :paid_order_with_random_user,      traits: [:paid, :with_random_user]
    factory :new_order_with_random_user,       traits: [:with_random_user]
  end 
end


def new_oreder_with_order_itmes(order_items_count: 5)
  FactoryBot.create(:new_order_with_random_user) do |order|
    FactoryBot.create_list(:order_item, order_items_count, order: order)
  end
end

def ordered_oreder_with_order_itmes(order_items_count: 5)
  FactoryBot.create(:ordered_order_with_random_user) do |order|
    FactoryBot.create_list(:order_item, order_items_count, order: order)
  end
end

def paid_oreder_with_order_itmes(order_items_count: 5)
  FactoryBot.create(:paid_order_with_random_user) do |order|
    FactoryBot.create_list(:order_item, order_items_count, order: order)
  end
end

def cancelled_oreder_with_order_itmes(order_items_count: 5)
  FactoryBot.create(:cancelled_order_with_random_user) do |order|
    FactoryBot.create_list(:order_item, order_items_count, order: order)
  end
end

def completed_oreder_with_order_itmes(order_items_count: 5)
  FactoryBot.create(:completed_order_with_random_user) do |order|
    FactoryBot.create_list(:order_item, order_items_count, order: order)
  end
end

