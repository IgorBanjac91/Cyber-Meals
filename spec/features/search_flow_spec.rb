require "rails_helper" 

RSpec.describe "search flow", type: :feature do 

  let(:user) { create(:user) }
  let(:user2) { create(:user, email: "user2@gmail.com") }
  
  let(:cocacola)  { create(:item, title: "Cocacola", description: "salty") }
  let(:carbonara) { create(:item, description: "salty hot") }
  let(:spaghetti) { create(:item, title: "Spaghetti", description: "salty smooth") }
  let(:gnocchi)   { create(:item, title: "Gnocchi" , description: "hot sweet")}
  let(:focaccia)  { create(:item, title: "Focaccia", description: "smooth Focaccia Spaghetti") }
  let(:pizza)     { create(:item, title: "Pizza", description: "sweet crust spicy Focaccia") }
  let(:tiramisu)  { create(:item, title: "Tiramisu", description: "spicy") }
  
  let(:order)  { create(:order, status: "new", user: user) }
  let(:order1) { create(:order, status: "completed", user: user) }
  let(:order2) { create(:order, status: "completed", user: user) }
  let(:order5) { create(:order, status: "completed", user: user) }
  let(:order4) { create(:order, status: "completed", user: user) }
  let(:order3) { create(:order, status: "ordered", user: user, preparation_time: "13") }
  let(:order6) { create(:order, status: "cancelled", user: user) }
  let(:order7) { create(:order, status: "cancelled", user: user) }
  let(:order8) { create(:order, status: "cancelled", user: user2) }

  before(:each) do
    
    user

    order1.order_items << create(:order_item, item: cocacola, quantity: 1)
    order1.order_items << create(:order_item, item: carbonara, quantity: 1)
    order1.order_items << create(:order_item, item: spaghetti, quantity: 1)

    order2.order_items << create(:order_item, item: cocacola, quantity: 1)
    order2.order_items << create(:order_item, item: carbonara, quantity: 1)
    order2.order_items << create(:order_item, item: spaghetti, quantity: 1)

    order3.order_items << create(:order_item, item: cocacola, quantity: 1)
    order3.order_items << create(:order_item, item: focaccia, quantity: 1)
    order3.order_items << create(:order_item, item: tiramisu, quantity: 1)

    order4.order_items << create(:order_item, item: cocacola, quantity: 1)
    order4.order_items << create(:order_item, item: focaccia, quantity: 1)
    order4.order_items << create(:order_item, item: tiramisu, quantity: 1)

    order5.order_items << create(:order_item, item: cocacola, quantity: 1)
    order5.order_items << create(:order_item, item: pizza, quantity: 1)
    order5.order_items << create(:order_item, item: tiramisu, quantity: 1)
    
    order6.order_items << create(:order_item, item: cocacola, quantity: 1)
    order6.order_items << create(:order_item, item: pizza, quantity: 1)
    order6.order_items << create(:order_item, item: spaghetti, quantity: 1)

    order7.order_items << create(:order_item, item: cocacola, quantity: 1)
    order7.order_items << create(:order_item, item: pizza, quantity: 1)
    order7.order_items << create(:order_item, item: tiramisu, quantity: 1)

    order8.order_items << create(:order_item, item: cocacola, quantity: 1)
    order8.order_items << create(:order_item, item: pizza, quantity: 1)
    order8.order_items << create(:order_item, item: tiramisu, quantity: 1)
  
    visit root_path
  end
  

  describe "seraching items by title" do 
    
    it "shows only the item with the wanted title" do 
      fill_in("query", with: "Carbonara")
      click_button("Search")
      expect(page).to have_content("Carbonara")
      expect(page).to have_css(".btn-add-to-cart", count: 1)
    end
  end
  
  
  describe "searching order by text" do 
    before(:each) do 
      sign_in user
      visit root_path
      click_link("Orders")
    end
    
    it "return the orders the include the text in the title" do 
      fill_in("query", with: "Pizza")
      click_button("Search")
      pp page.body
      expect(page).to have_content(order5.id)
      expect(page).to have_content(order6.id)
      expect(page).to have_content(order7.id)
      expect(page).to have_css("tr", count: 4)
    end

    it "return the orders the include the text in the description" do 
      fill_in("query", with: "smooth")
      click_button("Search")
      expect(page).to have_content(order1.id)
      expect(page).to have_content(order2.id)
      expect(page).to have_content(order3.id)
      expect(page).to have_content(order4.id)
      expect(page).to have_content(order6.id)
      expect(page).to have_css("tr", count: 6)
    end
    
    it 'return the orders that includes the text in both the items description and title' do 
      fill_in("query", with: "Spaghetti")
      click_button("Search")
      expect(page).to have_content(order1.id)
      expect(page).to have_content(order2.id)
      expect(page).to have_content(order3.id)
      expect(page).to have_content(order4.id)
      expect(page).to have_content(order6.id)
      expect(page).to have_css("tr", count: 6)
    end
    
    it "doesn't show other users orders" do 
      fill_in("query", with: "Focaccia")
      expect(page).to_not have_content(order8.id)
    end
  end
end