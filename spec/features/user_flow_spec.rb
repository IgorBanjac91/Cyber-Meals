require "rails_helper"

RSpec.describe "User flow", type: :feature do 

  before do 
    @dessert_items = category_with_items(:desserts).items
    visit root_path
  end

  context "Unauthanticated User" do 

    it 'sees all items on the home page' do 
      @items.each do |item|
        expect(page).to have_content(item.title)
      end 
    end

    it 'can browse items by category' do 
      # coose form category list
      # chosse one 
      # click search
      # see only the items with the choosen category
    end
  end
end