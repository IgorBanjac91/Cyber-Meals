require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do 

    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:username).is_at_least(2).is_at_most(32) }
  
  end
end
