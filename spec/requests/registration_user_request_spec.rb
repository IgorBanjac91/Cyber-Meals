require "rails_helper"

RSpec.describe "user registration", type: :request do 

  
  context "when trying to set a user as an admin" do 
    
    describe "POST registration#create" do 
      it "dosn't create a new user" do 
        expect {
          post user_registration_path, params: { user: attributes_for(:user, :admin) } 
        }.to change(User, :count).by 0
      end
    end

    before(:each) do 
      @user = create(:user)
    end

    describe "PATCH registration#update" do 
      it "dosn't upgrade an user to admin" do 
        patch user_registration_path(id: @user.id), params: { user: attributes_for(:user, :admin) }
        expect(@user.admin).to be false
      end
    end
  end
end