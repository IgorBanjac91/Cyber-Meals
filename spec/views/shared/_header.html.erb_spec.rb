require 'rails_helper' 

RSpec.describe 'shared/_header.html.erb', type: :view do 
  
  context "for every type of user" do 

    it "shows the cart link" do 
      order = create(:order)
      render
      expect(rendered).to have_link("Cart", href: order_path(Order.last))
    end
  end

  context "with unauthenticated user" do 

    before(:each) do 
      render
    end

    it 'shows the sing up link' do 
      expect(rendered).to have_link("Sign up", href: sign_up_path)
    end
    
    it 'shows the log in link' do 
      expect(rendered).to have_link("Sign in", href: sign_in_path)
    end
    
    it "doesn't show the log out link" do 
      expect(rendered).to_not have_link("Log out", href: log_out_path)
    end

    it "doesn't show the orders link" do 
      expect(rendered).to_not have_link("Orders", href: orders_path)
    end
  end
  
  context "with authenticated user" do 
    
    before(:each) do 
      user = create(:user)
      sign_in user
      render
    end

    it "doesn't show the sing up link" do 
      expect(rendered).to_not have_link("Sign up", href: sign_up_path)
    end
    
    it "doesn't show the log in link" do 
      expect(rendered).to_not have_link("Sign in", href: sign_in_path)
    end

    it "shows the log out link" do 
      expect(rendered).to have_link("Log out", href: log_out_path)
    end

    it "shows the orders link" do 
      expect(rendered).to have_link("Orders", href: orders_path)
    end

  end

end