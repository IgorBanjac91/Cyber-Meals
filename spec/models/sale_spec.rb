require 'rails_helper'

RSpec.describe Sale, type: :model do

  describe "validations" do 

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:discount) }
    it { should validate_numericality_of(:discount).is_greater_than_or_equal_to(0)
                                                   .is_less_than_or_equal_to(100) }
  end

  describe "associations" do 
    
    it { should have_many(:categories) }
    it { should have_many(:items) }

  end

end
