FactoryBot.define do
  factory :order do
    status { "new" }
  end 

  trait :cancelled do 
    status { "cancelled" }
  end
  trait :completed do 
    status { "completed" }
  end
  trait :ordered do 
    status { "ordered" }
  end

  trait :with_user do 
    user 
  end
end
