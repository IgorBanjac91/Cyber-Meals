require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do 

    subject { build(:item) }

    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:price).is_greater_than(0) }

  end

  describe 'associations' do 
    it { should have_and_belong_to_many(:categories) }
    it { should have_and_belong_to_many(:orders) }
    it { should have_many(:order_items)}
  end
    
end
