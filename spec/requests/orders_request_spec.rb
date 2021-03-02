require 'rails_helper'

RSpec.describe "Orders", type: :request do

  let(:user) { create(:user) } 
  let(:order) { create(:order) }

  context "when a user is unauthenticated" do 


    before(:each) do 
      @other_user_order = create(:order, user: create(:random_user))
    end

    describe "GET /show" do 
      it 'cannot render others order show page' do 
        get order_path(@other_user_order)
        expect(response).to redirect_to root_path
      end
    end

    describe "GET /edit" do 
      it "can't render edit page" do 
        get edit_order_path(@other_user_order)
        expect(response).to redirect_to root_path
      end
    end
  end

  context "when a user is authenticated" do

    before(:each) do 
      sign_in user
    end
    
    describe "GET /index" do 
      it "successfully renders the index page" do 
        get orders_path
        expect(response).to be_successful
      end
    end
    
  end
end
