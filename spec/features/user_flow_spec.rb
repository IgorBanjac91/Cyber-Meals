require "rails_helper"

RSpec.describe "User flow", type: :feature do 

  
  before do 
    @items = category_with_items.items
    @desserts = desserts_category_with_items.items
    @lactose_free = lactose_free_category_with_items.items
    visit root_path
  end

  context "Unauthanticated User" do 

    it 'sees all items on the home page' do 
      @items.each do |item|
        expect(page).to have_content(item.title)
      end 
    end

    it 'can browse items by category' do 
      select("Desserts", from: "category_id")
      click_button("Filter")
      @desserts.each do |dessert|
        expect(page).to have_content(dessert.title)
      end
      @items.each do |item|
        expect(page).to_not have_content(item.title)
      end
      @lactose_free.each do |dish| 
        expect(page).to_not have_content(dish.title)
      end
    end
    
    it 'has each itme with a Add to Cart button' do
      @items.each do |item| 
        expect(page).to have_button("Add to Cart")
      end
    end

    it 'add and order item to the cart' do 
      click_button("Add to Cart", match: :first)
      expect(current_path).to eq(order_path(Order.last))
      expect(page).to have_content("1 Item")
    end
  end
end