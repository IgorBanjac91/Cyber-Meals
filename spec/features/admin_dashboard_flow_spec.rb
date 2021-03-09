require "rails_helper" 

RSpec.describe "admin_dashboard", type: :feature do 

  let(:admin) { create(:user, :admin) }

  before(:each) do 
    sign_in admin
    5.times do 
      new_oreder_with_order_itmes
      cancelled_oreder_with_order_itmes
      completed_oreder_with_order_itmes
      ordered_oreder_with_order_itmes
      paid_oreder_with_order_itmes
    end
    @orders = Order.all
    visit dashboard_path
  end

  describe "dashboard page" do 

    it "shows all the orders" do 
      @orders.each do |order|
        expect(page).to have_content(order.id)
      end
    end

    describe "filter orders" do 

      it "filters order by status 'new'" do 
        new_orders = Order.where(status: "new")
        other_orders = Order.where.not(status: "new")
        pp page.body
        find(:css, "#status_new[value='new']").set(true)
        find(:css, "#status_completed[value='completed']").set(false)
        find(:css, "#status_ordered[value='ordered']").set(false)
        find(:css, "#status_cancelled[value='cancelled']").set(false)
        find(:css, "#status_paid[value='paid']").set(false)
        click_button("Filter")
        new_orders.each do |order|
          expect(page).to have_content(order.id)
        end
        other_orders.each do |order|
          expect(page).to_not have_content(order.id)
        end
      end

      it "filters order by setting more than one status" do 
        new_orders = Order.where(status: "new")
        other_orders = Order.where.not(status: "new")
        find(:css, "#status_new[value='new']").set(false)
        find(:css, "#status_paid[value='paid']").set(true)
        find(:css, "#status_completed[value='completed']").set(true)
        find(:css, "#status_ordered[value='ordered']").set(true)
        find(:css, "#status_cancelled[value='cancelled']").set(true)
        click_button("Filter")
        new_orders.each do |order|
          expect(page).to_not have_content(order.id)
        end
        other_orders.each do |order|
          expect(page).to have_content(order.id)
        end
      end
    end
  end

end