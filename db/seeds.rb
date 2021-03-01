admin = User.create!(email: "admin@gmail.com", password: "foobar", password_confirmation: "foobar", admin: true, 
                    first_name: "admin", last_name: "admin", username: "admin")


drink = Category.create(name: "Drink")
beer_category = Category.create(name: "Beer")
dessert = Category.create(name: "Dessert")
lactose_free = Category.create(name: "Lactose Free")
vegan = Category.create(name: "Vegan")
appetizer = Category.create(name: "Appetaizer")
main_dish = Category.create(name: "Main Dish")


coke = Item.create(title: "Coke", description: "Classic Coke", price: Faker::Number.decimal(l_digits: 2))
broccoli_dish = Item.create(title: "Broccoli boom", description: "Broccoli dish, very spice", price: Faker::Number.decimal(l_digits: 2))
green_soup = Item.create(title: "Green soup", description: "Vegetable soup", price: Faker::Number.decimal(l_digits: 2))
fake_cheese = Item.create(title: "Fake cheese", description: "Veggy cheese", price: Faker::Number.decimal(l_digits: 2))

lactose_free.items << fake_cheese
lactose_free.items << coke
lactose_free.items << broccoli_dish

vegan.items << coke
vegan.items << fake_cheese
vegan.items << broccoli_dish

beers = []
9.times do
   beers << Item.create(title: Faker::Beer.unique.name, description: Faker::Beer.yeast, price: Faker::Number.decimal(l_digits: 2)) 
end

beers.each do |beer|
  drink.items << beer
  beer_category.items << beer
end

7.times do 
  dessert.items << Item.create(title: Faker::Dessert.unique.variety, 
                               description: Faker::Dessert.flavor, 
                               price: Faker::Number.decimal(l_digits: 2))
end

2.times do 
  lactose_free.items << Item.create(title: Faker::Food.unique.sushi, 
                                    description: Faker::Food.description, 
                                    price: Faker::Number.decimal(l_digits: 2))
end

2.times do 
  vegan.items << Item.create(title: Faker::Food.unique.vegetables, 
                             description: Faker::Food.description, 
                             price: Faker::Number.decimal(l_digits: 2))
end

2.times do 
  appetizer.items << Item.create(title: Faker::Food.unique.fruits, 
                                description: Faker::Food.description, 
                                price: Faker::Number.decimal(l_digits: 2))
end

6.times do 
  main_dish.items << Item.create(title: Faker::Food.unique.dish, 
                                 description: Faker::Food.description, 
                                 price: Faker::Number.decimal(l_digits: 2))
end


user_1 = User.create!(email: "example@gmail.com", first_name: "Bob", password: "foobar", password_confirmation: "foobar",
                    last_name: "Fish", username: "Bobby")

Order.create!(user: user_1, status: "new")
Order.create!(user: user_1, status: "cancelled")
Order.create!(user: user_1, status: "cancelled")
Order.create!(user: user_1, status: "ordered")
Order.create!(user: user_1, status: "ordered")
Order.create!(user: user_1, status: "completed")
Order.create!(user: user_1, status: "completed")

Order.create!(user: admin, status: "new")
Order.create!(user: admin, status: "cancelled")
Order.create!(user: admin, status: "cancelled")
Order.create!(user: admin, status: "cancelled")
Order.create!(user: admin, status: "ordered")
Order.create!(user: admin, status: "ordered")
Order.create!(user: admin, status: "completed")
Order.create!(user: admin, status: "completed")