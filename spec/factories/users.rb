FactoryBot.define do
  factory :user do
    email       { "bobbyfish@gmail.com"}
    first_name  { "Bob"}
    last_name   { "Fish"}
    username    { "Bobby"}
    password              { "password" }
    password_confirmation { "password" }
    admin { false }
  end

  factory :random_user, class: User do
    email       { Faker::Internet.email }    
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    username    { Faker::Internet.username(specifier: 2..32)}
    password              { "password" }
    password_confirmation { "password" }
  end

  trait :admin do 
    admin { true }
  end
  
end

def random_user_with_completed_orders(count_orders: 5)
  FactoryBot.create(:random_user) do |random_user|
    FactoryBot.create_list(:order, count_orders, user: random_user)
  end
end
