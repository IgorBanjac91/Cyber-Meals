require 'rails_helper'

RSpec.describe "Orders", type: :request do

  context "when a user is unautheticated" do 

    before(:each) do 
      @order = create(:order)
      @other_user = create(:user)
      @other_user_order = create(:order, user: @other_user)
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
end
