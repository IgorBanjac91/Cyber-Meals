require "rails_helper" 

RSpec.describe "orders/show.html.erb", tyep: :view do 

  let(:item) { create(:random_item, price: 2.22) }
  let(:item_2) { create(:random_item, price: 5.00) }
  let(:item_3) { create(:random_item, price: 7.00) }
  let(:order_item) { create(:order_item, item: item, quantity: 2) }
  let(:order_item_2) { create(:order_item, item: item_2, quantity: 2) }
  let(:order_item_3) { create(:order_item, item: item_3, quantity: 2) }
  let(:order) { create(:order) }

  before(:each) do 
    order = create(:order)
    order.order_items << order_item
    order.order_items << order_item_2
    order.order_items << order_item_3
    assign(:order, order)
    render
  end

  it "display the order statur" do 
    expect(rendered).to have_content(order.status)
  end
  
  it "displays the total items number" do 
    expect(rendered).to match /<span>3<\/span>/
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
  
  it "shows the price of each item" do 
    order.order_items.each do |order_item|
      expect(rendered).to have_content(order_item.item.price)
    end
  end

  it "shows the total price" do 
    expect(rendered).to have_content("28.44")
  end

  context "when the order status is cancelled" do 
    
    let(:order_cancelled) { create(:order, :cancelled) }
    
    before(:each) do 
      assign(:order, order_cancelled)
      render
    end
    
    it "show the date when it was cancelled" do 
      expect(rendered).to have_content(order_cancelled.updated_at)
    end
  end
  
  context "when the order status is completed" do 
    
    let(:order_completed) { create(:order, :completed) }
    
    before(:each) do 
      assign(:order, order_completed)
      render
    end
    
    it "show the date when it was completed" do 
      expect(rendered).to have_content(order_completed.updated_at)
    end
    
  end
  
  context "when the order status is ordered" do 
    
    let(:order_ordered) { create(:order, :ordered) }
    
    before(:each) do 
      assign(:order, order_ordered)
      render
    end

    it "show the date when it was ordered" do 
      expect(rendered).to have_content(order_ordered.updated_at)
    end
    
  end

end