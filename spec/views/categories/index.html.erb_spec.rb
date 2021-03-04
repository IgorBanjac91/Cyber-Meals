require 'rails_helper'

RSpec.describe "categories/index.html.erb", type: :view do

  before(:each) do 
    @categories = create_list(:category, 5)
    assign(:categories, @categories)
    render
  end

  it "has an edit link for each category" do 
    @categories.each do |category|
      expect(rendered).to have_link("edit", href: category_path(category))
    end
  end

  it "has an delete link for each category" do 
    @categories.each do |category|
      expect(rendered).to have_link("delete", href: category_path(category))
    end
  end
end

