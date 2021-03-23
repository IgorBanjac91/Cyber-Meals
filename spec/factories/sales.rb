FactoryBot.define do
  factory :sale do
    title { "Black Friday" }    
    discount { 50 }

    trait :invalid do 
      title { "" }
      discount { 200 }
    end
  end

end
