FactoryBot.define do
  factory :order do
    status { "new" }
  end 
  
  trait :with_user do 
    user 
  end
end
