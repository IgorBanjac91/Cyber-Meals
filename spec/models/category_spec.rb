require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "validations" do 
    it { should validate_presence_of(:name) }
  end

  describe "associations" do 
    it { should have_and_belong_to_many(:items)}
  end

end
