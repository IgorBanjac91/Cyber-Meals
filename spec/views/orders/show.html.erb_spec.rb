require "rails_helper" 

RSpec.describe "orders/show.html.erb", tyep: :view do 

  
  let(:item) { create(:random_item, price: 2.22) }
  let(:order_item) { create(:order_item, item: item, quantity: 2) }
  let(:order) { create(:order) }

  before(:each) do 
    order = create(:order)
    order.order_items << create(:order_item) 
    order.order_items << order_item
    assign(:order, order)
    render
  end

  it "displays the orders items total number" do 
    expect(rendered).to have_content("2 Items")
  end
  
  it "show the sub-totala of an item" do 
    expect(rendered).to have_content("4.44")
  end
  
  it "renders all the orders itmes" do 
    order.order_items.each do |order_item|
      expect(rendered).to have_content(order_item.item.title)
    end
  end
  
  it "render a back to itmes link" do 
    expect(rendered).to have_link("Back", href: root_path)
  end
  
  it "show the price of each item" do 
    order.order_items.each do |order_item|
      expect(rendered).to have_content("4.44")
    end
  end

end