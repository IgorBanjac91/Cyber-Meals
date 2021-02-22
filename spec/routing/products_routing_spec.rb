require "rails_helper" 

RSpec.describe ItemsController, type: :routing do 
  
  describe "routing" do 
    
    it { should route(:get,  '/').to(action: :index) }

  end
end