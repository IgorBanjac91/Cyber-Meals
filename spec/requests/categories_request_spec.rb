require 'rails_helper'

RSpec.describe "Categories", type: :request do

  before(:each) do 
    @category = create(:category)
    create(:random_category)
  end

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

    context "when a user is an admin" do 

      before(:each) do 
        sign_in admin_user
      end
      
      context "with valid attributes" do 
        
        it "creates a new category" do 
          expect {
            post categories_path, params: { category: attributes_for(:category, name: "Example") }
          }.to change(Category, :count).by 1
        end
      end
      
      context "with invalid attributes" do 
        
        it "doesn't create a new category" do 
          expect {
            post categories_path, params: { category: attributes_for(:category, :invalid) }
          }.to change(Category, :count).by 0
        end
        
        it "renders the index page" do 
          post categories_path, params: { category: attributes_for(:category, :invalid) }
          expect(response).to redirect_to categories_path
        end
      end
    
    end
  end

  describe "DELETE categories#delete" do 

    let(:category) { create(:category) }

    context "when a user isn't authenticated" do 
      
      it "dosn't delete the category" do 
        expect {
          delete category_path(@category)
        }.to change(Category, :count).by 0
      end
      
      it "redirect to the sing in page" do
        delete category_path(@category)
        expect(response).to redirect_to sign_in_path
      end
    end
    
    context "when a user is authenticated but not admin" do 
      
      before(:each) do
       sign_in regular_user  
      end
      
      it "dosen't delete the category" do 
        expect {
          delete category_path(@category)
        }.to change(Category, :count).by 0
      end
      
      it "returns a forbidden http status code" do 
        delete category_path(@category)
        expect(response).to have_http_status(:forbidden)
      end
    end
    
    context "when a user is an admin" do 
      
      before(:each) do 
        sign_in admin_user  
      end
      
      it "returns ok response and deletes the category" do 
        expect {
          delete category_path(@category)
        }.to change(Category, :count).by -1
      end
      
      it "reditects to the index page" do 
        delete category_path(@category)
        expect(response).to redirect_to categories_path
      end
    end
  end

end
