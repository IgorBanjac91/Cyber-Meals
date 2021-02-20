require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do 
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_presence_of(:categories) }
  end

  describe 'associations' do 
    it { should have_and_belong_to_many(:categories) }
    it { should have_and_belong_to_many(:orders) }
  end
    
end
