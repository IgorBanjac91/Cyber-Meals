require 'rails_helper' 

RSpec.describe 'menu_option', type: :feature do 

  let(:user) { create(:user) }

  let(:polenta) { create(:item, title: "Polenta", price: 10) }
  let(:pizza) { create(:item, title: "Pizza", price: 10) }
  let(:tiramisu) { create(:item, title: "Tiramisu", price: 10) }
  let(:peroni) { create(:item, title: "Peroni", price: 10) }

  let(:main) { create(:category, name: "Main Dish" )} 
  let(:dessert) { create(:category, name: "Dessert" )}  
  let(:appetaizer) { create(:category, name: "Appetaizer" )}  
  let(:drink) { create(:category, name: "Drink" )}  


  before(:each) do 
    appetaizer.items << polenta
    main.items << pizza
    dessert.items << tiramisu
    drink.items << peroni
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
      pp page.body
      expect(page).to have_content("Polenta + Pizza + Tiramisu + Peroni")
      expect(page).to have_content("$36.00")
    end
  end
end
