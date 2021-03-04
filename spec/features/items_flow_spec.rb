require "rails_helper" 

RSpec.describe "items_flow_spec.rb", type: :feature do 

  context "for administrators only" do 

    let(:admin) { create(:user, :admin) }
    let(:item) { create(:item, title: "Carbonara", description: "always good", price: "10.00") }

    before(:each) do 
      item
      sign_in admin
      visit root_path
    end

    describe "item creation flow" do 

      it "creates  a new item" do 
        click_link("New Item", href: new_item_path) 
        fill_in("Title", with: "Beefsteak")
        fill_in("Description", with: "Jucy steak with roasted potatos")
        fill_in("Price", with: "10.50")
        click_button("Create")
        expect(current_path).to eq item_path(Item.last)
      end
    end
    
    describe "edit item flow" do 
      
      it "edits an existing item" do 
        click_link("show", href: item_path(item))
        click_link("Edit", href: edit_item_path(item))
        fill_in("Title", with: "Steak")
        fill_in("Description", with: "Juicy")
        fill_in("Price", with: "13")
        click_button("Edit")
        edited_item = Item.last
        expect(current_path).to eq item_path(edited_item)
        expect(page).to have_content("Steak")
        expect(page).to have_content("Juicy")
        expect(page).to have_content("13")
      end
    end

    describe "add catgory to an item" do 

      it "add a new category to an item" do 
        click_link("show", href: item_path(item))
        select("Desserts", from: "categories")
        click_button("Add catgory")
        click_link("Back")
        expect(page).to have_content("Dessert")
      end
    end
  end
end