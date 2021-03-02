require "rails_helper" 

RSpec.describe "order_items_flow", type: :feature do 

  let(:retired_item) { create(:item, :retired) }

  describe "add retired item to cart" do 

    before(:each) do 
      retired_item
    end

    it 'shows a denided operation message' do 
      visit root_path
      click_button("Add to Cart")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You cannot add #{retired_item.title}, item retired from the menu")
    end
  end
end