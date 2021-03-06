require "rails_helper"

RSpec.describe "categories_flow", type: :feature do 

  let(:admin_user) { create(:user, :admin) }

  before(:each) do 
    sign_in admin_user
    visit root_path
  end

  describe "creating new category" do 

    context "when the user is an admin" do 
      
      it "creates a new category" do 
        click_link("New Category", href: categories_path)
        fill_in("Category name", with: "new category")
        click_button("Add Category")
        expect(current_path).to eq categories_path
        expect(page).to have_content("new category") 
      end
    end
  end

  describe "editing an existing category" do 

    let(:category) { create(:category) }

    before(:each) do 
      create(:category)
      create(:category, :desserts)
    end

    context "when the user is an admin" do 

      it 'edits the category' do 
        visit categories_path
        click_link("edit", match: :first) 
        fill_in("Name", with: "new name")
        click_button("Edit")
        expect(current_path).to eq categories_path
        expect(page).to have_content("new name")
      end
    end
  end

end