require 'rails_helper' 

RSpec.describe 'shared/_header.html.erb', type: :view do 
  
  context "with unauthenticated user" do 

    before(:each) do 
      render
    end

    it 'renders the sing up link' do 
      expect(rendered).to have_link("Sign up", href: sign_up_path)
    end

    it 'renders the log in link' do 
      expect(rendered).to have_link("Sign in", href: sign_in_path)
    end
  end

end