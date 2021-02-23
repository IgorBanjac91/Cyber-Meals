require "rails_helper" 

RSpec.describe "orders/show.html.erb", tyep: :view do 

  before(:each) do 
    @order = create(:order)
    4.times { @order.items << create(:item) }
    assign(:items, @order.items)
    render
  end

  it "displays the number orders items number" do 
    expect(rendered).to have_content("4 Items")
  end

  it "renders all the orders itmes" do 
    @order.items.each do |item|
      expect(rendered).to have_content(item.title)
    end
  end

  it "render a back to itmes link" do 
    expect(rendered).to have_link("Back", href: root_path)
  end
end