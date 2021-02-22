require "rails_helper"

RSpec.describe "User flow", type: :feature do 

  before do 
    @items = category_with_items.items
    @desserts = desserts_category_with_items
    @lactose_free = lactose_free_category_with_items
    visit root_path
  end

  context "Unauthanticated User" do 

    it 'sees all items on the home page' do 
      @items.each do |item|
        expect(page).to have_content(item.title)
      end 
    end

    it 'can browse items by category' do 
      select("Desserts", from: "Category")
      click_button("Filter")
      @desserts.each do |dessert|
        expect(page).to have_content(dessert.title)
      end
      @item.each do |item|
        expect(page).to_not have_content(item.title)
      end
      @lactose_free.each do |dish| 
        expect(page).to_not have_content(dish.title)
      end
    end
  end
end