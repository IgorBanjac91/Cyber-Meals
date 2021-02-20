require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'validations' do 
    it { should validate_presence_of(:user) }
  end

  describe 'associations' do 
    it { should have_and_belong_to_many(:items) }
    it { should belong_to(:user)}
  end
end
