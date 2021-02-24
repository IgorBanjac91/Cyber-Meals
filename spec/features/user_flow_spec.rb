require "rails_helper"

RSpec.describe "User flow", type: :feature do 

  
  before do 
    @items = category_with_items.items
    @desserts = desserts_category_with_items.items
    @lactose_free = lactose_free_category_with_items.items
    visit root_path
  end

  context "Unauthanticated User" do 

    context "Allowed behaviours" do 

      it 'sees all items on the home page' do 
        @items.each do |item|
          expect(page).to have_content(item.title)
        end 
      end
  
      it 'browses items by category' do 
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
      
      it 'adds an order item to the cart' do 
        click_button("Add to Cart", match: :first)
        expect(current_path).to eq(order_path(Order.last))
        expect(page).to have_content("1 Item")
      end
      
      it "changes the order item quantity" do 
        click_button("Add to Cart", match: :first)
        click_link("1", href: edit_order_item_path(OrderItem.last))
        select("4", from: "order_item_quantity")
        click_button("Edit")
        expect(page).to have_content("4")
      end
      
      it "keeps the order after sing up" do 
        click_button("Add to Cart", match: :first)
        click_link("Sign up")
        fill_in("First name", with: "Bob")
        fill_in("Last name", with: "Fish")
        fill_in("Username", with: "Bobby")
        fill_in("Email",    with: "example@gmail.com")
        fill_in("Password", with: "password")
        fill_in("Password confirmation", with: "password")
        click_button("Sign up")
        click_link("Cart")
        expect(current_path).to eq order_path(Order.last)
      end
    end

    context "Prohibited behaviours" do 
      
    end
  end
end