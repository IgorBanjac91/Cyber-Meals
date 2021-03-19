require "rails_helper" 

RSpec.describe "items/show.html.erb", tyep: :view do 
  
  let(:item) { create(:item, title: "Steak", description: "Juicy", price: 23.33, categories: [create(:random_category)] ) }

  before(:each) do 
    assign(:item, item)
    categories_selector = item.categories.map { |c| [c.name, c.id] }
    assign(:categorizations, Categorization.all)
    assign(:categories, categories_selector)
    render
  end

  it "shows item information" do 
    
    expect(rendered).to match /Steak/
    expect(rendered).to match /Juicy/
    expect(rendered).to match /23.33/
  end

  it "shows a list of categories" do 
    item.categories.each do |category|
      expect(rendered).to match /#{category.name}/
    end
  end
end