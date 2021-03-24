require "rails_helper"

RSpec.describe "review flow", type: :feature do
  
  let(:item) { create(:item, title: "example") }
  let(:user) { create(:user) }

  describe "review creation" do 

    context "for unauthenticated users" do 

      it "doesn't show the review form" do 
        visit item_path(item)
        expect(page).to_not have_css("input", id: "review_title")
      end
    end
    
    context "for authenticated users" do 
      
      before(:each) do 
        sign_in user
        visit item_path(item)
      end
      
      it "shows the review form" do 
        expect(page).to have_css("input", id: "review_title")
        expect(page).to have_css("input", id: "review_rating")
        expect(page).to have_css("textarea", id: "review_body")
      end
      
      it "create a new review" do 
        fill_in("Title", with: "review title")
        fill_in("Body", with: "the body review text")
        fill_in("Rating", with: "4")
        click_button("Submit Review")
        expect(current_path).to eq item_path(item)
        pp page.body
        expect(page).to have_content("review title")
        expect(page).to have_content("the body review text")
        expect(page).to have_content("4")
      end
    end
  end
  
  describe "update review" do 
    
    before(:each) do 
      sign_in user
      visit item_path(item)
    end

    let(:review) { create(:review, item: item, user: user) }
    let(:old_review) { create(:review, :old_review, item: item, user: user) }
    
    context "within 15 minutes after creation" do 

      it 'updates the review' do 
        review
        visit item_path(item)
        click_link("Edit Review", href: edit_review_path(review))
        pp page.body
        fill_in("Title", with: "new title")
        fill_in("Body", with: "new body")
        fill_in("Rating", with: "3")
        click_button("Update")
        expect(current_path).to eq item_path(item)
        expect(page).to have_content("new title")
        expect(page).to have_content("new body")
        expect(page).to have_content("3")
      end
    end

    context "15 minutes after creation" do 

      it "doesn't show the Edit Review button" do 
        old_review 
        expect(page).to_not have_button("Edit Review")
      end
    end
  end


end