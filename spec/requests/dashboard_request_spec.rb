require 'rails_helper'

RSpec.describe "Dashboards", type: :request do

  let(:adim_user) { create(:user, :admin) }
  let(:regular_user) { create(:user) } 

  describe "GET /index" do

    context "when the user is an administrator" do 

      before(:each) do 
        sign_in :adim_user
      end
      
      it "returns http success" do
        get "/dashboard"
        expect(response).to have_http_status(:success)
      end
    end
    
  end
  
  describe "GET /show" do 
    
    context "when the user is an administrator" do 

      before(:each) do 
        create(:order, :with_random_user)
        sign_in :adim_user
      end

      it "returns http success" do
        get "/dashboard/orders/1"
        expect(response).to have_http_status(:success)
      end
    end
  end

end
