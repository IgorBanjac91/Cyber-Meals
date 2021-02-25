require "rails_helper" 

RSpec.describe "orders/index.html.erb" do 

  # Data, create different order (ordered, completed, cancelled
before(:each) do 
  new_orders = create(:order)
  ordered_orders = create(:order, status: "ordered")
  completed_orders = create(:order, status: "completed")
  cancelled_orders = create(:order, status: "cancelled")
  @orders = Order.all
  assign(:orders, @orders)
  render
end
  

  it "shows the user orders" do 
    @orders.each do |order| 
      expect(rendered).to have_content(order.id)
      expect(rendered).to have_content(order.created_at)
      expect(rendered).to have_content(order.status)
      expect(rendered).to have_link("Show", href: order_path(order))
    end
  end
end
