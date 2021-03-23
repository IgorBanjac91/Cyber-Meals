require "rails_helper"

RSpec.describe "sales/show.html.erb", type: :view do 

  let(:admin) { create(:user, :admin) }
  let(:item_1) { create(:item, title: "item1", price: "20") }
  let(:item_2) { create(:item, title: "item2", price: "10") }
  let(:category) { create(:category, name: "main")}
  let(:sale) { create(:sale, title: "example", discount: 10) }

  before(:each) {
    sign_in admin
    sale.items << [item_1, item_2]
    sale.categories << [category]
    assign(:categories, Category.all)
    assign(:items, Item.all)
    assign(:sale, sale)
    render
  }

  it "renders the items on sale" do 
    expect(rendered).to have_content(item_1.title)
    expect(rendered).to have_content(item_2.title)
  end

  it "renders the category on sale" do 
    expect(rendered).to have_content(category.name)
  end

  it "renders the orginal price and the discounted price" do 
    expect(rendered).to have_content(item_1.price)
    expect(rendered).to have_content("18")
    expect(rendered).to have_content(item_2.price)
    expect(rendered).to have_content("9")
  end
end