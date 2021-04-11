require "rails_helper" 

RSpec.describe "search flow", type: :feature do 

  let(:user) { create(:user) }
  let(:user2) { create(:user, email: "user2@gmail.com") }
  let(:admin_user) { create(:user, :admin, email: "admin@gmail.com") }
  
  let(:cocacola)  { create(:item, title: "Cocacola", description: "salty", price: 1) }
  let(:carbonara) { create(:item, description: "salty hot", price: 1) }
  let(:spaghetti) { create(:item, title: "Spaghetti", description: "salty smooth", price: 1) }
  let(:gnocchi)   { create(:item, title: "Gnocchi" , description: "hot sweet", price: 2)}
  let(:focaccia)  { create(:item, title: "Focaccia", description: "smooth Focaccia Spaghetti", price: 2) }
  let(:pizza)     { create(:item, title: "Pizza", description: "sweet crust spicy Focaccia", price: 3) }
  let(:tiramisu)  { create(:item, title: "Tiramisu", description: "spicy", price: 3) }
  
  let(:order)  { create(:order, status: "new", user: user, updated_at: "10-05-2021") }
  let(:order1) { create(:order, status: "completed", user: user, updated_at: "10-06-2021") }
  let(:order2) { create(:order, status: "completed", user: user, updated_at: "10-07-2021") }
  let(:order3) { create(:order, status: "ordered", user: user, preparation_time: "13", updated_at: "10-07-2021") }
  let(:order4) { create(:order, status: "completed", user: user, updated_at: "10-08-2021") }
  let(:order5) { create(:order, status: "completed", user: user, updated_at: "10-08-2021") }
  let(:order6) { create(:order, status: "cancelled", user: user, updated_at: "10-09-2021") }
  let(:order7) { create(:order, status: "cancelled", user: user, updated_at: "10-09-2021") }
  let(:order8) { create(:order, status: "cancelled", user: user2, updated_at: "10-10-2021") }
  let(:order9) { create(:order, status: "ordered", user: user2, preparation_time: "15", updated_at: "10-11-2021") }
  let(:order10) { create(:order, status: "paid", user: user2, preparation_time: "15", updated_at: "10-12-2021") }

  before(:each) do
    
    user
    #Total Price: 3
    order1.order_items << create(:order_item, item: cocacola, quantity: 1)
    order1.order_items << create(:order_item, item: carbonara, quantity: 1)
    order1.order_items << create(:order_item, item: spaghetti, quantity: 1)
    #Total Price: 3
    order2.order_items << create(:order_item, item: cocacola, quantity: 1)
    order2.order_items << create(:order_item, item: carbonara, quantity: 1)
    order2.order_items << create(:order_item, item: spaghetti, quantity: 1)
    #Total Price: 6
    order3.order_items << create(:order_item, item: cocacola, quantity: 1)
    order3.order_items << create(:order_item, item: focaccia, quantity: 1)
    order3.order_items << create(:order_item, item: tiramisu, quantity: 1)
    #Total Price: 6
    order4.order_items << create(:order_item, item: cocacola, quantity: 1)
    order4.order_items << create(:order_item, item: focaccia, quantity: 1)
    order4.order_items << create(:order_item, item: tiramisu, quantity: 1)
    #Total Price: 7
    order5.order_items << create(:order_item, item: cocacola, quantity: 1)
    order5.order_items << create(:order_item, item: pizza, quantity: 1)
    order5.order_items << create(:order_item, item: tiramisu, quantity: 1)
    #Total Price: 5
    order6.order_items << create(:order_item, item: cocacola, quantity: 1)
    order6.order_items << create(:order_item, item: pizza, quantity: 1)
    order6.order_items << create(:order_item, item: spaghetti, quantity: 1)
    #Total Price: 7
    order7.order_items << create(:order_item, item: cocacola, quantity: 1)
    order7.order_items << create(:order_item, item: pizza, quantity: 1)
    order7.order_items << create(:order_item, item: tiramisu, quantity: 1)
    #Total Price: 7
    order8.order_items << create(:order_item, item: cocacola, quantity: 1)
    order8.order_items << create(:order_item, item: pizza, quantity: 1)
    order8.order_items << create(:order_item, item: tiramisu, quantity: 1)
    #Total Price: 2
    order9.order_items << create(:order_item, item: gnocchi, quantity: 1)
    #Total Price: 3
    order10.order_items << create(:order_item, item: tiramisu, quantity: 1)
    
    visit root_path
  end
  
  context "for regular users" do 

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

  context "for admin users" do 

    before(:each) do 
      sign_in admin_user
      visit dashboard_path
    end

    describe "searching through orders" do 

      describe "filter form" do 

        it "has a dropdown menu for selecting status name" do 
          expect(page).to have_select("Status", options: ["", "Completed", "Cancelled", "Paid", "Ordered"])
        end

        it "has dropdown with '<', '>', '=' and text field combined" do 
          expect(page).to have_select("total_sign", options: ["<", ">", "="])
          expect(page).to have_field("Total", type: "number")
        end

        it "has dropdown with '<', '>', '=' and date field combined" do 
          expect(page).to have_select("date_sign", options: ["<", ">", "="])
          expect(page).to have_field("Date", type: "date")
        end

        it "has email field for email" do 
          expect(page).to have_field("Email", type: "text")
        end
      end

      it "filters orders by status" do 
        select("Cancelled", from: "Status") 
        click_button("Filter") 
        expect(page).to have_content(order6.id)
        expect(page).to have_content(order7.id)
        expect(page).to have_content(order8.id)
        expect(page).to have_css("tr", count: 4)
      end
      
      it "filters orders by user email" do 
        fill_in("Email", with: "user2@gmail.com")
        click_button("Filter")
        expect(page).to have_content(order8.id)
        expect(page).to have_content(order9.id)
        expect(page).to have_content(order10.id)
        expect(page).to have_css("tr", count: 4)
      end
      
      describe "filtering by date" do 
        
        it "filters orders before a certain date" do 
          select("<", from: "date_sign")
          fill_in("Date", with: "10/08/2021")
          click_button("Filter")
          expect(page).to have_content(order1.id)
          expect(page).to have_content(order2.id)
          expect(page).to have_content(order3.id)
          expect(page).to have_css("tr", count: 4)
        end

        it "filters orders after a certain date" do 
          select(">", from: "date_sign")
          fill_in("Date", with: "10/08/2021")
          click_button("Filter")
          expect(page).to have_content(order6.id)
          expect(page).to have_content(order7.id)
          expect(page).to have_content(order8.id)
          expect(page).to have_content(order9.id)
          expect(page).to have_content(order10.id)
          expect(page).to have_css("tr", count: 6)          
        end
        
        it "filters orders at a certain date" do 
          select("=", from: "date_sign")
          fill_in("Date", with: "10/08/2021")
          click_button("Filter")
          expect(page).to have_content(order4.id)
          expect(page).to have_content(order5.id)
          expect(page).to have_css("tr", count: 3)          
        end
      end

      describe "filtering by total price" do 
        
        it "filters orders with a total price less than a certain amount" do 
          select("<", from: "total_sign")
          fill_in("Total", with: "5")
          click_button("Filter")
          expect(page).to have_content(order1.id)
          expect(page).to have_content(order2.id)
          expect(page).to have_content(order9.id)
          expect(page).to have_content(order10.id)
          expect(page).to have_css("tr", count: 5)          
        end
        
        it "filters orders with a total price grather than a certain amount" do 
          select(">", from: "total_sign")
          fill_in("Total", with: "5")
          click_button("Filter")
          expect(page).to have_content(order3.id)
          expect(page).to have_content(order4.id)
          expect(page).to have_content(order5.id)
          expect(page).to have_content(order7.id)
          expect(page).to have_content(order8.id)
          expect(page).to have_css("tr", count: 6)          
        end
        
        it "filters orders with a total price equal to a certain amount" do 
          select("=", from: "total_sign")
          fill_in("Total", with: "5")
          click_button("Filter")
          expect(page).to have_content(order6.id)
          expect(page).to have_css("tr", count: 2)          
        end
      end

      it "filters with multiple options" do 
        select("Cancelled", from: "Status") 
        select(">", from: "total_sign")
        fill_in("Total", with: "5")
        select(">", from: "date_sign")
        fill_in("Date", with: "10/09/2021")
        click_button("Filter") 
        expect(page).to have_content(order8.id)
        expect(page).to have_css("tr", count: 2)          
      end
    end
  end
end