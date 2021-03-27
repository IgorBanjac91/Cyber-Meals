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
  let(:order4) { create(:order, status: "completed", user: user_3) }
  let(:order5) { create(:order, status: "completed", user: user_1) }
  let(:order6) { create(:order, status: "completed", user: user_1) }
  let(:order7) { create(:order, status: "completed", user: user_1) }
  let(:order8) { create(:order, status: "completed", user: user_1) }
  let(:order9) { create(:order, status: "completed", user: user_2) }
  let(:order10) { create(:order, status: "completed", user: user_2) }
  let(:order11) { create(:order, status: "completed", user: user_2) }
  let(:order12) { create(:order, status: "completed", user: user_2) }

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

    # creation orders for testin popular items

    order4.order_items << create(:order_item, item: pizza, quantity: 1)
    order5.order_items << create(:order_item, item: pizza, quantity: 1)
    order6.order_items << create(:order_item, item: pizza, quantity: 1)
    order7.order_items << create(:order_item, item: carbonara, quantity: 1)
    order8.order_items << create(:order_item, item: carbonara, quantity: 1)
    order9.order_items << create(:order_item, item: carbonara, quantity: 1)
    order10.order_items << create(:order_item, item: focaccia, quantity: 1)
    order11.order_items << create(:order_item, item: gnocchi, quantity: 1)
    order12.order_items << create(:order_item, item: cocacola, quantity: 1)

  end

  before(:each) do 
    visit root_path
    click_button("Add to Cart", match: :first) # add CocaCola
  end

  describe "suggesting combination items" do 

    it 'shows the suggested items after adding the first item' do 
      expect(page).to have_content("Spaghetti")
      expect(page).to have_content("Carbonara") 
    end
    
    it "add suggested items to current order" do 
      within("aside.suggested-items") do 
        click_button("Add to Cart", match: :first)
      end
      expect(find("table")).to have_content("Carbonara")
    end
  end

  describe "suggegsting popular items" do 
    
    it "suggests the top 3 elements on the order show page" do 
      within(".popular-items") do 
        expect(page).to have_content("Pizza")
        expect(page).to have_content("Carbonara")
        expect(page).to have_content("Cocacola")
      end
    end
  end
end