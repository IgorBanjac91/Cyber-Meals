require "rails_helper"

RSpec.describe "User flow", type: :feature do 

  before do 
    @user = create(:user, email: "example@gmail.com")
    @items = category_with_items.items
    @desserts = desserts_category_with_items.items
    @lactose_free = lactose_free_category_with_items.items
    visit root_path
  end

  describe "shwoign the cart" do 

    context "whe no items in the cart" do 
      it "does nothing" do 
        click_link("Cart")
        expect(current_path).to eq root_path
      end
    end
    
    context "when itmes in the cart" do 
      it "shows the cart page" do 
        click_link("Cart") 
        expect(current_path).to eq root_path  
      end
    end
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
    end 
    
    it "keeps the order after sing in" do 
      click_button("Add to Cart", match: :first)
      sign_in @user
      expect(current_path).to eq order_path(Order.last)
    end

  end

  context "Authenticated User non-admin" do 

    before(:each) do 
     sign_in @user
    end

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
    
    before do 
      
    end

    it 'can see past orders' do 
      click_link("Orders", href: orders_path)
      expect(page).to 

    end
  end
end 