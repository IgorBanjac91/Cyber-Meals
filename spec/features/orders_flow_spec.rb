require "rails_helper"

RSpec.describe "orders_flow", type: :feature do 

  before do 
    @user = create(:user)
    @new_orders = create_list(:order, 4, status: "new")
    @cancelled_orders = create_list(:order, 4, status: "cancelled")
    @completed_orders = create_list(:order, 4, status: "completed")
    @ordered_orders = create_list(:order, 4, status: "ordered")
    @user.orders << @new_orders
    @user.orders << @cancelled_orders
    @user.orders << @completed_orders
    @user.orders << @ordered_orders
    sign_in @user
  end

  describe "browse orders by status" do 

    before(:each) do 
      visit root_path
      click_link("Orders")
    end

    describe "clicking all" do 

      it "shows all orders" do 
        click_link("All")
        @user.orders.each do |order|
          expect(page).to have_content(order.id)
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
      
      it 'shows only cancelled oreders' do 
        click_link("Ordered")
        @ordered_orders.each do |order|
          expect(page).to have_content(order.id)
        end
      end
    end

    describe "clicking completed status order link" do 
      
      it 'shows only cancelled oreders' do 
        click_link("Completed")
        @completed_orders.each do |order|
          expect(page).to have_content(order.id)
        end
      end
    end

    describe "clicking new status orderd link" do 
      
      it 'shows only cancelled oreders' do 
        click_link("New")
        @new_orders.each do |order|
          expect(page).to have_content(order.id)
        end
      end
    end

  end

  describe "showing item description" do 

    before do 

      @orders = orders_with_order_items
      
      @user.orders = []
      @user.orders << @orders
    end

    context "clicking item description link" do 
      
      it "shows the item description page" do
        visit orders_path
        click_link("Show", match: :first)
        click_link("description", match: :first)
        first_order_item = @orders.order_items.first
        expect(current_path).to eq item_path(first_order_item.item)
      end
    end
  end
end