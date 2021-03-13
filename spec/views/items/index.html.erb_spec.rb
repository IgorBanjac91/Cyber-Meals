require 'rails_helper'

RSpec.describe "items/index.html.erb", type: :view do
  
  let(:regular_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let(:retired_item) { create(:item,:retired, title: "Retired item") }
  let(:valid_item) { create(:item, title: "Valid item", price: "2.22") }
  
  before(:each) do 
    items = []
    items << retired_item
    items << valid_item
    assign(:items, items)
    category_options = ["Dinner", "Sweet"]
    assign(:category_options, category_options)
    render
  end

  context "when an item is in the menu" do 
    
    it "appears on the menu" do 
      expect(rendered).to match /Valid item/
    end

    it 'show his price' do 
      expect(rendered).to match /2.22/
    end
  end

  context "when an item is retired" do 
    
      context "for unauthorized users" do 
        it "dosen't show the item" do 
          expect(rendered).to_not match /Retired item/
        end
      end
      
      context "for authorazed users but not admin" do 

        before(:each) do
          sign_in regular_user
        end
        
        it "dosen't show the item" do 
          expect(rendered).to_not match /Retired item/
        end
      end
      
      context "for admin users" do 

        before(:each) do
          sign_in admin_user
          render
        end

        it "it shows the item" do 
          expect(rendered).to match /Retired item/
        end
      end
  end

  
end
