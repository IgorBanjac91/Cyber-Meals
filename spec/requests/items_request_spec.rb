require 'rails_helper'

RSpec.describe "Items", type: :request do

  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /item" do 

    let(:retired_item) { create(:item, :retired) }

    context "when an item is in the menu" do 

      it "returns a successful response" do 
        get item_path(retired_item)
        expect(response).to be_successful
      end
    end
    
    context "when an item is retired from the menu" do 
      
      it "returns a successful response" do 
        get item_path(retired_item)
        expect(response).to be_successful
      end
    end
  
  end

end
