require "rails_helper"

RSpec.describe "sales flow", tyep: :feature do 

  let(:admin) { create(:user, :admin) }
  let(:main_category) { create(:category, :main) }
  let(:item_1) { create(:item, title: "Polenta", categories: [main_category]) }
  let(:item_2) { create(:item, title: "Chicken", categories: [main_category]) }
  let(:item_3) { create(:item, title: "Ossobuco", categories: [main_category]) }
  let(:sale) { create(:sale) }
  
  before(:each) do 
    main_category
    item_1
    item_2
    item_3
    sign_in admin
    visit new_sale_path
  end

  describe "create sale flow" do 


    it 'creates a new sale for specific items' do 
      fill_in("Title", with: "Black Friday")
      fill_in("Discount in %", with: "50")
      find("label[for=sale_item_ids_1]").click
      find("label[for=sale_item_ids_2]").click
      find("label[for=sale_item_ids_3]").click
      click_button("Create Sale")
      sale = Sale.last
      expect(current_path).to eq sale_path(sale)
      expect(page).to have_content(sale.title)
      expect(page).to have_content(item_1.title)
      expect(page).to have_content(item_2.title)
      expect(page).to have_content(item_3.title)
    end

  end

  describe "delete sale flow" do
    
    it 'deletes a sale' do 
      sale_to_delete = create(:sale, title: "Sale to Delete")
      click_link("Sales")
      find('li', text: "Sale to Delete").click_link("delete")
      expect(current_path).to eq sales_path
      expect(page).to_not have_content(sale_to_delete.title)
    end
  end

end