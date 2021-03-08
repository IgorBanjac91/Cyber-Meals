require 'rails_helper'

RSpec.describe Order, type: :model do

  describe "validations" do 
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(['new', 'completed', 'cancelled', 'ordered']) }
  end
  
  describe 'associations' do 
    it { should have_many(:order_items)}
  end
end
