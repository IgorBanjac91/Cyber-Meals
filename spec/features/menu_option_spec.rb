require 'rails_helper' 

RSpec.describe 'menu_option', type: :feature do 

  let(:user) { create(:user) }

  let(:polenta) { create(:item, title: "Polenta", price: 10) }
  let(:pizza) { create(:item, title: "Pizza", price: 10) }
  let(:tiramisu) { create(:item, title: "Tiramisu", price: 10) }
  let(:peroni) { create(:item, title: "Peroni", price: 10) }
  let(:polenta_2) { create(:item, title: "Polenta_2", price: 10) }
  let(:pizza_2) { create(:item, title: "Pizza_2", price: 10) }
  let(:tiramisu_2) { create(:item, title: "Tiramisu_2", price: 10) }
  let(:peroni_2) { create(:item, title: "Peroni_2", price: 10) }

  let(:main) { create(:category, name: "Main Dish" )} 
  let(:dessert) { create(:category, name: "Dessert" )}  
  let(:appetaizer) { create(:category, name: "Appetaizer" )}  
  let(:drink) { create(:category, name: "Drink" )}  

  let(:order) { create(:order) }
  let(:menu) { create(:menu, order: order, items: [polenta, pizza, tiramisu, peroni]) }

  before(:each) do 
    appetaizer.items << [polenta, polenta_2]
    main.items << [pizza, pizza_2]
    dessert.items << [tiramisu, tiramisu_2]
    drink.items << [peroni, peroni_2]
    menu
  end

  describe "create your own menu" do 
    
    it 'creates the menu and adds it to the order with 10% discount' do 
      visit root_path
      click_link("Menu Option", href: new_menu_path)
      select("Polenta", from: "menu_appetaizer_id")
      select("Pizza", from: "menu_main_dish_id")
      select("Tiramisu", from: "menu_dessert_id")
      select("Peroni", from: "menu_drink_id")
      click_button("Add to Order")
      expect(current_path).to eq order_path(Order.last)
      expect(page).to have_content("Polenta + Pizza + Tiramisu + Peroni")
      expect(page).to have_content("$36.00")
    end
  end
  
  describe "editing the menu's items" do 
    it "edit the itmes" do 
      visit order_path(order.id)
      click_link("Edit Menu")
      select("Polenta_2", from: "menu_appetaizer_id")
      select("Pizza_2", from: "menu_main_dish_id")
      select("Tiramisu_2", from: "menu_dessert_id")
      select("Peroni_2", from: "menu_drink_id")
      click_button("Update Menu")
      expect(page).to have_content("Polenta_2 + Pizza_2 + Tiramisu_2 + Peroni_2")
    end
  end
  
  describe "removing menu item from order" do

    it "removes the item from the menu" do 
      visit order_path(order.id)
      click_link("Remove Menu")
      expect(page).to_not have_content("Polenta + Pizza + Tiramisu + Peroni")
    end
  end
end
