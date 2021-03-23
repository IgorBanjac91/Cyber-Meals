require 'rails_helper'

RSpec.describe "Sales", type: :request do


  describe 'GET #new' do 

    it "returns a successful response" do 
      get new_sale_path
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do 
    
    context "with valid parameters" do 

      it 'creates a new sale' do
        expect {
          post sales_path, params: { sale: attributes_for(:sale) }
        }.to change(Sale, :count).by 1
      end
      
      it 'redirects to the sale page' do 
        post sales_path, params: { sale: attributes_for(:sale) }
        expect(response).to redirect_to sale_path(Sale.last)
      end
    end
    
    context "with invalid parameters" do 
      
      it "doesn't create a new sale" do
        expect {
          post sales_path, params: { sale: attributes_for(:sale, :invalid) }
        }.to change(Sale, :count).by 0
      end

      it 'renders the new sale page' do 
        post sales_path, params: { sale: attributes_for(:sale, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  let(:sale) { create(:sale) }

  before(:each) do 
    sale
  end

  describe 'DELETE #destory' do 

    it "deletes a sale" do 
      expect {
        delete sale_path(sale)
      }.to change(Sale, :count).by -1
    end
    
    it "redirects to the index sales page" do 
      delete sale_path(sale)
      expect(response).to redirect_to(sales_path)
    end
  end
end
