require 'rails_helper'

RSpec.describe Order, type: :model do

  describe "validations" do 
    
    context "if status ordered" do 

      before do
        allow(subject).to receive(:status_ordered?).and_return(true)
      end
      
      it { should validate_presence_of(:preparation_time) }
      
    end
    
    context "if status not ordered" do 

      before do
        allow(subject).to receive(:status_ordered?).and_return(false)
      end
      
      it { should_not validate_presence_of(:preparation_time) }
    end

    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(['new', 'completed', 'cancelled', 'ordered', 'paid']) }
  end
  
  describe 'associations' do 
    it { should have_many(:order_items)}
  end
end


