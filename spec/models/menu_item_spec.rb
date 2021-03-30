require 'rails_helper'

RSpec.describe MenuItem, type: :model do

  describe "associations" do 

    it { should belong_to(:item) }
    it { should belong_to(:menu) }
  end
end
