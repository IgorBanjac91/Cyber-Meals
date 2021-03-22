require "rails_helper"

RSpec.describe "sales flow", tyep: :feature do 

  let(:admin) { create(:user, :admin) }
  let(:main_category) { create(:category, :main) }
  let(:item_1) { create(:item, title: "Polenta", categories: [main_category]) }
  let(:item_2) { create(:item, title: "Chicken", categories: [main_category]) }
  let(:item_3) { create(:item, title: "Ossobuco", categories: [main_category]) }
  

  describe "create sale flow" do 

    before(:each) do 
      main_category
      item_1
      item_2
      item_3
      sign_in admin
      visit new_sale_path
    end

    it 'creates a new sale for specific items' do 
      fill_in("Title", with: "Black Friday")
      fill_in("Discount in %", with: "50")
      find("label[for=sale_item_ids_1]").click
      find("label[for=sale_item_ids_2]").click
      find("label[for=sale_item_ids_3]").click
      click_button("Create Sale")
      expect(current_path).to eq sales_path
      
    end

  end

end