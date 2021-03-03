require 'rails_helper'

RSpec.describe "Items", type: :request do

  let(:regular_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }

  describe "GET items#index" do 

    it "returns a successfull response" do 
      get items_path
      expect(response).to be_successful
    end
  
  end

  describe "GET items#new" do 

    context "when the user is a visitor" do

      it "redirects to the home sign in page" do
        get new_item_path
        expect(response).to redirect_to sign_in_path
      end      
    end

    context "when the user is authenticated but not an admin" do

      it "redirects to the home page" do 
        sign_in regular_user
        get new_item_path
        expect(response).to redirect_to root_path
      end
    end

    context "when the user is an admin" do 

      it "has a successfull response and render the index page" do 
        sign_in admin_user
        get new_item_path
        expect(response).to be_successful
        expect(response).to render_template :new
      end
    end
  end

end
