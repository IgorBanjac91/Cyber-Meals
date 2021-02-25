require "rails_helper"

RSpec.describe "user registration", type: :request do 

  
  context "with unpermitted parameters (admin: ture)" do 
    
    describe "POST /sing_up" do 
      it "dosn't create a new user" do 
        expect {
          post sign_up_path, params: attributes_for(:user, :admin) 
        }.to change(User, :count).by 0
      end
    end

    before do 
      @user = create(:user)
    end

    describe "PATCH /update" do 
      it "dosn't upgrade an user to admin" do 
        patch user_registration_path, params: attributes_for(:user, :admin)
        expect(@user.admin).to be false
      end
    end
  end
end