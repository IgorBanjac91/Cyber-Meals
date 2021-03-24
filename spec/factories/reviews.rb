FactoryBot.define do
  factory :review do
    title { "title review" }
    body { "body text review" }
    rating { "5" }
    user
    item 

    trait :old_review do 
      created_at { Time.now + 15.minutes }
    end
  end
end
