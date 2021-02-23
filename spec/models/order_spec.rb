require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'associations' do 
    it { should have_and_belong_to_many(:items) }
    it { should have_many(:order_items)}
  end
end
