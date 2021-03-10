require 'rails_helper'

RSpec.describe "dashboard/index.html.erb", type: :view do

  let(:admin) { create(:user, :admin) }
  let(:new_order) { new_oreder_with_order_itmes }
  let(:cancelled_order) { cancelled_oreder_with_order_itmes }
  let(:completed_order) { completed_oreder_with_order_itmes }
  let(:ordered_order) { ordered_oreder_with_order_itmes }
  let(:paid_order) { paid_oreder_with_order_itmes }

  before(:each) do 
    sign_in admin
    # Creaion of all kind of orders
    new_order
    cancelled_order
    completed_order
    ordered_order
    paid_order
    @orders = Order.all
    render
  end

  it 'renders a show link for each order' do 
  end

  it "renders 'cancel' link near paid orders and ordered orders" do 
    expect(rendered).to have_link("cancel", count: 2) 
  end

  it "renders 'mark as paid' link near ordered orders" do 
    expect(rendered).to have_link("mark as paid", count: 1)
  end
  
  
  it "renders 'mark as completed' link near paid orders" do 
    expect(rendered).to have_link("mark as completed", count: 1)
  end
end
