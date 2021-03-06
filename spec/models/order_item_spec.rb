require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe "associations" do 
    it { should belong_to(:item) }
    it { should belong_to(:order) }
  end
end
