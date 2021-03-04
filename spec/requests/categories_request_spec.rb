require 'rails_helper'

RSpec.describe "Categories", type: :request do

  let(:regular_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }

  describe "GET categoris#index" do 

    context "when a user isn' authenticated" do 
      
      it "redirect to the sing in page" do
        get categories_path
        expect(response).to redirect_to sign_in_path
      end
    end

    context "when a user is authenticated but not admin" do 
      
      it "returns a forbidden http status code" do 
        sign_in regular_user
        get categories_path
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "when a user is and admin" do 

      it "return ok and renders the template" do 
        sign_in admin_user
        get categories_path
        expect(response).to be_successful
        expect(response).to render_template :index
      end
    end
  end

  describe "POST categoris#create" do 

    context "when a user isn' authenticated" do 
      
      it "redirect to the sing in page" do
        get categories_path, params: { category: attributes_for(:category) }
        expect(response).to redirect_to sign_in_path
      end
    end

    context "when a user is authenticated but not admin" do 
      
      it "returns a forbidden http status code" do 
        sign_in regular_user
        get categories_path, params: { category: attributes_for(:category) }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "when a user is and admin" do 

      before(:each) do 
        sign_in admin_user
      end
      
      context "with valid attributes" do 
        
        it "creates a new category" do 
          expect {
            post categories_path, params: { category: attributes_for(:category) }
          }.to change(Category, :count).by 1
        end
      end
      
      context "with invalid attriburs" do 
        it "doesn't create a new category and render index" do 
          expect {
            post categories_path, params: { category: attributes_for(:category, :invalid) }
          }.to change(Category, :count).by 0
          expect(response).to render_template :index
        end
      end
    
    end
  end

end
