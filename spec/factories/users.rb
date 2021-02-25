FactoryBot.define do
  factory :user do
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
