require "rails_helper" 

RSpec.describe "orders/show.html.erb", tyep: :view do 

  before(:each) do 
    @order = create(:order)
    4.times { @order.order_items << create(:order_item) }
    item = create(:item, price: 2.22)
    order_item = create(:order_item, item: item, quantity: 2)
    @order.order_items << order_item
    assign(:order, @order)
    render
  end

  it "displays the orders items number" do 
    expect(rendered).to have_content("5 Items")
  end
  
  it "show the sub-totala of an item" do 
    expect(rendered).to have_content("4.44")
  end
  
  it "renders all the orders itmes" do 
    @order.order_items.each do |order_item|
      expect(rendered).to have_content(order_item.item.title)
    end
  end
  
  it "render a back to itmes link" do 
    expect(rendered).to have_link("Back", href: root_path)
  end
  
  it "show the price of each item" do 
    @order.order_items.each do |order_item|
      expect(rendered).to have_content(order_item.item.price)
    end
  end

end