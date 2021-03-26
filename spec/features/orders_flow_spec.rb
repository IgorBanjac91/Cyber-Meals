require "rails_helper"

RSpec.describe "orders_flow", type: :feature do 

  let(:user) { create(:user) }
  let(:user_2) { create(:random_user)}

  before(:each) do 
    @new_order = create(:order, user: user)
    @last_completed_order = create(:order, user: user)
    @last_completed_order.order_items = create_list(:order_item, 5)
    @cancelled_orders = create_list(:order, 4, user: user, status: "cancelled")
    @completed_orders = create_list(:order, 4, user: user, status: "completed")
    @completed_orders_2 = create_list(:order, 4, user: user, status: "completed")
    @ordered_orders = create_list(:order, 4, user: user, status: "ordered", preparation_time: 0)
    sign_in user
  end

  describe "adding last order items to new order" do 

    it 'adds the items' do 
      visit order_path(@new_order)
      click_link("Order Again")
      expect(@new_order.order_items).to eq(@last_order.order_items)
    end
  end

  describe "browse orders by status" do 

    before(:each) do 
      visit root_path
      click_link("Orders")
    end

    describe "clicking all" do 

      it "shows all orders except new" do 
        click_link("All")
        user.orders.each do |order|
          if order.new?
            expect(page).to_not have_content(order.id)
          else
            expect(page).to have_content(order.id)
          end
        end
      end
    end

    describe "clicking cancelled status order link" do 
      
      it 'shows only cancelled oreders' do 
        click_link("Cancelled")
        @cancelled_orders.each do |order|
          expect(page).to have_content(order.id)
        end
      end
    end

    describe "clicking ordered status order link" do 
      
      it 'shows only ordered oreders' do 
        click_link("Ordered")
        @ordered_orders.each do |order|
          expect(page).to have_content(order.id)
        end
      end
    end

    describe "clicking completed status order link" do 
      
      it 'shows only completed oreders' do 
        click_link("Completed")
        @completed_orders.each do |order|
          expect(page).to have_content(order.id)
        end
      end
    end
  end

  describe "submitting order" do 

    it 'has a submtim order button at the order page' do 
      order = create(:order, user: user, status: "new")
      order.order_items << create(:order_item)
      visit order_path(order)
      expect(page).to have_button("Submit Order")
    end
    
    it "changes the status order from new to submitted" do 
      sign_in user
      order = create(:order, user: user, status: "new")
      order.order_items << create(:order_item)
      visit order_path(order)
      click_button("Submit Order")
      order.reload
      expect(order.status).to eq "ordered"
      expect(current_path).to eq order_path(order)
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.status)
    end
    
    
    context "when the order itmes are less than 6" do 

      let(:order) { create(:order, user: user, status: "new") }
      before(:each) do 
        sign_in user 
        visit order_path(order)
      end
      
      it "shows the estimated preparation time without extra time" do 
        order.order_items << create(:order_item, quantity: 5)
        click_button("Submit Order")
        order.reload
        expect(page).to have_content("60 minutes")
      end
      
      it "shows the estimated preparation with 10 minutes extra every 6 items" do 
        order.order_items << create(:order_item, quantity: 12)
        click_button("Submit Order")
        order.reload
        expect(page).to have_content("164 minutes")        
      end
    end
  end
end