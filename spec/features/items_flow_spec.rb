require "rails_helper" 

RSpec.describe "items_flow_spec.rb", type: :feature do 

  context "for administrators" do 

    let(:admin) { create(:user, :admin) }
    
    before(:each) do 
      sign_in admin
      visit root_path
    end

    describe "item creation" do 

      it "creates  a new item" do 
        click_link("New Item", href: new_item_path) 
        fill_in("Title", with: "Beefsteak")
        fill_in("Description", with: "Jucy steak with roasted potatos")
        fill_in("Price", with: "10.50")
        click_button("Create")
        expect(current_path).to eq item_path(Item.last)
      end
    end
  end
end