require 'rails_helper'

RSpec.describe Menu, type: :model do

  let(:menu) { build(:menu) }
  let(:invalid_menu) { build(:menu, :invalid) }

  describe "validation" do 

    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:percentage) }
    it { should validate_presence_of(:quantity) }

    context "when ther is an item for each category" do 

      it "is valid" do 
        expect(menu).to be_valid
      end
    end

    context "when there isn't an item for each category" do 

      it "is invalid" do
        expect(invalid_menu).to_not be_valid
      end
    end
    
  end

  describe "associtaions" do 

    it { should have_many(:menu_items) } 
    it { should belong_to(:order) }
  end
end
