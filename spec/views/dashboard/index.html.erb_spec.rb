require 'rails_helper'

RSpec.describe "dashboard/index.html.erb", type: :view do

  let(:admin) { create(:user, :admin) }
  let(:cancelled_order) { cancelled_oreder_with_order_itmes }
  let(:completed_order) { completed_oreder_with_order_itmes }
  let(:ordered_order) { ordered_oreder_with_order_itmes }
  let(:paid_order) { paid_oreder_with_order_itmes }

  before(:each) do 
    sign_in admin
    cancelled_order
    completed_order
    ordered_order
    paid_order
    @orders = Order.all
    assign(:statuses, @orders)
    render
  end

  describe "links on the page" do 
    
    it 'renders a show link for each order' do 
      @orders.each do |order|
        expect(rendered).to have_link("show", href: dashboard_orders_path(order))
      end
    end
  
    it "renders 'cancel' link near paid orders and ordered orders" do 
      expect(rendered).to have_link("cancel", count: 2) 
    end
  
    it "renders 'paid' link near ordered orders" do 
      expect(rendered).to have_link("paid", count: 1)
    end
    
    
    it "renders 'mark as completed' link near paid orders" do 
      expect(rendered).to have_link("completed", count: 1)
    end
  end
  
end
