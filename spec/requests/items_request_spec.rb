require 'rails_helper'

RSpec.describe "Items", type: :request do

  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to render_template(:index)
    end
  end

end
