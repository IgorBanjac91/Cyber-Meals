require "rails_helper" 

RSpec.describe "orders/index.html.erb" do 

before(:each) do 
  new_orders = create(:order, status: "new")
  @orders = Order.all
  assign(:orders, @orders)
  render
end
  

  it "shows the user orders" do 
    @orders.each do |order| 
      expect(rendered).to have_content(order.id)
      expect(rendered).to have_content(pretty_date(order.created_at))
      expect(rendered).to have_content(order.status)
      expect(rendered).to have_link("Show", href: order_path(order))
    end
  end
end
