require "rails_helper"

RSpec.describe "suggested itmes", type: :feature do 

  let(:user) { create(:user) }

  let(:user_1) { create(:user, email: "user1@gmail.com") }
  let(:user_2) { create(:user, email: "user2@gmail.com") }
  let(:user_3) { create(:user, email: "user3@gmail.com") }

  let(:cocacola)  { create(:item, title: "Cocacola") }
  let(:carbonara) { create(:item) }
  let(:spaghetti) { create(:item, title: "Spaghetti") }
  let(:gnocchi)   { create(:item, title: "Gnocchi") }
  let(:focaccia)  { create(:item, title: "Focaccia") }
  let(:pizza)     { create(:item, title: "Pizza") }
  let(:tiramisu)  { create(:item, title: "Tiramisu") }

  let(:order)  { create(:order, status: "new", user: user) }
  let(:order1) { create(:order, status: "completed", user: user_1) }
  let(:order2) { create(:order, status: "completed", user: user_2) }
  let(:order3) { create(:order, status: "completed", user: user_3) }

  before do 
    order1.order_items << create(:order_item, item: cocacola, quantity: 1)
    order1.order_items << create(:order_item, item: carbonara, quantity: 1)
    order1.order_items << create(:order_item, item: spaghetti, quantity: 1)

    order2.order_items << create(:order_item, item: cocacola, quantity: 1)
    order2.order_items << create(:order_item, item: carbonara, quantity: 1)
    order2.order_items << create(:order_item, item: spaghetti, quantity: 1)

    order3.order_items << create(:order_item, item: cocacola, quantity: 1)
    order3.order_items << create(:order_item, item: pizza, quantity: 1)
    order3.order_items << create(:order_item, item: tiramisu, quantity: 1)
  end

  describe "suggesting combination items" do 

    it 'shows the suggested items after adding the first item' do 
      visit root_path
      click_button("Add to Cart", match: :first) # add CocaCola
      expect(page).to have_content("Spaghetti")
      expect(page).to have_content("Carbonara") 
    end
    
    it "add suggested items to current order" do 
      visit root_path
      click_button("Add to Cart", match: :first) # add CocaCola
      pp page.body
      within("aside.suggested-items") do 
        click_button("Add to Cart", match: :first)
      end
      expect(find("table")).to have_content("Carbonara")
    end
    
  end
end