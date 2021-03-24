require 'rails_helper'

RSpec.describe "Reviews", type: :request do

  # only authenticated users can create reviews
  # only authenticated users can update reviews but until 15 minute after creation 

  let(:user) { create(:user) }
  let(:item) { create(:item)}


  describe "POST #create" do 

    context "for unauthenticated users" do 

      it "doesn't create a new review" do 
        expect {
          post reviews_path, params: { review: attributes_for(:review) }
        }.to change(Review, :count).by 0
      end
      
      it "redirects to the sign in page" do 
        post reviews_path, params: { review: attributes_for(:review) }
        redirect_to sign_in_path
      end
    end

    context "for unauthenticated users" do 

      before(:each) do 
        sign_in user
        item
      end

      it "creates a new review and stays on the same page" do 
        expect {
          post reviews_path, params: { review: attributes_for(:review, item_id: item.id, user_id: user.id) }
        }.to change(Review, :count).by 1
        expect(response).to redirect_to item_path(item)
      end
    end
  end
end
