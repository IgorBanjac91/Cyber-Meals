require 'rails_helper'

RSpec.describe "Items", type: :request do

  let(:regular_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let(:item) { create(:item) }

  describe "GET items#index" do 

    it "returns a successfull response" do 
      get items_path
      expect(response).to be_successful
    end
  
  end

  describe "GET items#show" do 

    it "returns a successfull response" do 
      get item_path(item)
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

      it "returns a forbidden status" do 
        sign_in regular_user
        get new_item_path
        expect(response).to have_http_status(:forbidden)
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

  describe "GET item#edit" do 

    context "when the user is a visitor" do

      it "redirects to the home sign in page" do
        get edit_item_path(item)
        expect(response).to redirect_to sign_in_path
      end      
    end

    context "when the user is authenticated but not an admin" do

      it "returns a forbidden status" do 
        sign_in regular_user
        get edit_item_path(item)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "when the user is an admin" do 

      it "has a successfull response and render the index page" do 
        sign_in admin_user
        get edit_item_path(item)
        expect(response).to be_successful
        expect(response).to render_template :edit
      end
    end
  end

  describe "POST itmes#create" do 

    context "when the user is a visitor" do

      it "redirects to sign in page" do
        post items_path, params: { item: attributes_for(:item) }
        expect(response).to redirect_to sign_in_path
      end      
    end
    
    context "when the authenticated user isn't an admin" do
      
      it "returns a frobidden status code" do
        post items_path, params: { item: attributes_for(:item) }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "when the authenticated user is an admin" do 

      it "creates a new item and redirects to the item page" do
     
      end
    end
  end

end
