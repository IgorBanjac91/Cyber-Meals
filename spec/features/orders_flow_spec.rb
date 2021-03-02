require "rails_helper"

RSpec.describe "orders_flow", type: :feature do 

  let(:user) { create(:user) }

  before(:each) do 
    @new_orders = create_list(:order, 4, user: user, status: "new")
    @cancelled_orders = create_list(:order, 4, user: user, status: "cancelled")
    @completed_orders = create_list(:order, 4, user: user, status: "completed")
    @ordered_orders = create_list(:order, 4, user: user, status: "ordered")
    sign_in user
  end

  describe "browse orders by status" do 

    before(:each) do 
      visit root_path
      click_link("Orders")
    end

    describe "clicking all" do 

      it "shows all orders" do 
        click_link("All")
        user.orders.each do |order|
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

    describe "clicking new status orderd link" do 
      
      it 'shows only new oreders' do 
        click_link("New")
        @new_orders.each do |order|
          expect(page).to have_content(order.id)
        end
      end
    end

  end
end