require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do 

    subject { build(:item) }

    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_presence_of(:preparation_time)}

  end

  describe 'associations' do 
      it { should have_many(:categories) }
      it { should have_many(:categorizations) }
      it { should have_many(:order_items)}
  end
    
end
