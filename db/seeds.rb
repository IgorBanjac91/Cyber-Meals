# ----------------- Users ---------------------------

admin = User.create!( email: "admin@gmail.com", 
                      admin: true, 
                      first_name: "admin", 
                      last_name: "admin", 
                      username: "admin", 
                      password: "foobar", password_confirmation: "foobar" )

user_1 = User.create!( email: "user1@gmail.com",
                       first_name: Faker::Name.first_name, 
                       last_name: Faker::Name.last_name, 
                       username: Faker::Internet.username, 
                       password: "foobar", password_confirmation: "foobar" )

user_2 = User.create!( email: "user2@gmail.com",
                       first_name: Faker::Name.first_name, 
                       last_name: Faker::Name.last_name, 
                       username: Faker::Internet.username, 
                       password: "foobar", password_confirmation: "foobar" )

user_3 = User.create!( email: "user3@gmail.com",
                       first_name: Faker::Name.first_name, 
                       last_name: Faker::Name.last_name, 
                       username: Faker::Internet.username, 
                       password: "foobar", password_confirmation: "foobar" )

user_4 = User.create!( email: "user4@gmail.com",
                       first_name: Faker::Name.first_name, 
                       last_name: Faker::Name.last_name, 
                       username: Faker::Internet.username, 
                       password: "foobar", password_confirmation: "foobar" )

# ----------------- Categories ---------------------------

drink = Category.create(name: "Drink")
beer_category = Category.create(name: "Beer")
dessert = Category.create(name: "Dessert")
lactose_free = Category.create(name: "Lactose Free")
vegan = Category.create(name: "Vegan")
appetizer = Category.create(name: "Appetaizer")
main_dish = Category.create(name: "Main Dish")

# ----------------- Items ---------------------------

beer_1 = Item.create(title: Faker::Beer.unique.name, description: Faker::Beer.yeast, price: Faker::Number.decimal(l_digits: 2)) 
beer_2 = Item.create(title: Faker::Beer.unique.name, description: Faker::Beer.yeast, price: Faker::Number.decimal(l_digits: 2)) 
beer_3 = Item.create(title: Faker::Beer.unique.name, description: Faker::Beer.yeast, price: Faker::Number.decimal(l_digits: 2)) 
sparkling_water = Item.create(title: "Sparkiling Water", description: "sparkling minearl water", price: Faker::Number.decimal(l_digits: 2))
still_water = Item.create(title: "Still Water", description: "still minearl water", price: Faker::Number.decimal(l_digits: 2))
coke = Item.create(title: "Coke", description: "Classic Coke", price: Faker::Number.decimal(l_digits: 2))
broccoli_dish = Item.create(title: "Broccoli boom", description: "Broccoli dish, very spice", price: Faker::Number.decimal(l_digits: 2))
green_soup = Item.create(title: "Green soup", description: "Vegetable soup", price: Faker::Number.decimal(l_digits: 2))
fake_cheese = Item.create(title: "Fake cheese", description: "Veggy cheese", price: Faker::Number.decimal(l_digits: 2))
carbonara = Item.create(title: "Carbonara", description: "Spaghetti with bacon and cheese", price: Faker::Number.decimal(l_digits: 2))
pizza = Item.create(title: "Pizza", description: "You know what a pizza is come on!", price: Faker::Number.decimal(l_digits: 2))
lasagna = Item.create(title: "Lasagna", description: "Flat past with a lot of ragu souce", price: Faker::Number.decimal(l_digits: 2))
fiorentina_steak = Item.create(title: "Fiorentina Steak", description: "Giagantic T-bone steak", price: Faker::Number.decimal(l_digits: 2))
polenta = Item.create(title: "Polenta", description: "Corn mush, from north Italy", price: Faker::Number.decimal(l_digits: 2))
ossobuco = Item.create(title: "Ossobuco", description: "Bone-in veal shank, cooked low and slow until meltingly tender in a broth of meat stock, white wine, and veggieas", price: Faker::Number.decimal(l_digits: 2))
risotto = Item.create(title: "Risotto", description: "creamy risotto", price: Faker::Number.decimal(l_digits: 2))
focaccia = Item.create(title: "Focaccia", description: "Tipical Touscan bread", price: Faker::Number.decimal(l_digits: 2))
coffee = Item.create(title: "Coffee", description: "plain coffee", price: Faker::Number.decimal(l_digits: 2))
tiramisu = Item.create(title: "Tiramisu", description: "Dessert with coffe cream cheese and cookies", price: Faker::Number.decimal(l_digits: 2))
chicken_tikka_masala = Item.create(title: "Chicken tikka masala", description: "Pieces of chicken tikka in a spiced creamy sauce", price: Faker::Number.decimal(l_digits: 2))
beef_wellington = Item.create(title: "Beef Wellington", description: "Beef cooked in a pastry crust", price: Faker::Number.decimal(l_digits: 2))
black_pudding = Item.create(title: "Black pudding", description: "Blood sausage", price: Faker::Number.decimal(l_digits: 2))
fish_and_chips = Item.create(title: "Fish and Chips", description: "White fish fillets in batter, deep fried with potato chips", price: Faker::Number.decimal(l_digits: 2))
kippers = Item.create(title: "Kipper", description: "Smokd split herrings", price: Faker::Number.decimal(l_digits: 2))

# ----------------- Associate Items with Categories ---------------------------

lactose_free.items << [fake_cheese, coke, green_soup, ossobuco, focaccia, coffee, black_pudding]

drink.items << [coke, coffee, still_water, 
                sparkling_water, beer_1, beer_2, beer_3]

main_dish.items << [carbonara, pizza, lasagna, 
                    fiorentina_steak, polenta, ossobuco, 
                    risotto, chicken_tikka_masala, beef_wellington, black_pudding]

appetizer.items << [focaccia, fish_and_chips, polenta, fake_cheese]

vegan.items << [coke, fake_cheese, broccoli_dish, polenta]

7.times do 
  dessert.items << Item.create(title: Faker::Dessert.unique.variety, 
                               description: Faker::Dessert.flavor, 
                               price: Faker::Number.decimal(l_digits: 2))
end

# ----------------- Orders ---------------------------

order_status = ["new", "cancelled", "completed", "ordered", "paid"]
users = [user_1, user_2, user_3, user_4]
items = Item.all 


# Creating different orders wiht different statuses for each user

users.each do |user|
  item = nil
  order_status.each do |order_status| 
    order = Order.create!(user: user, status: order_status)
    5.times do
      new_item = items.sample
      until item != new_item
        new_item = items.sample
      end
      OrderItem.create!(item: new_item, quantity: Faker::Number.within(range: 1..4), order: order )
    end
  end
end




