require "rails_helper"

RSpec.describe "User creation flow" do 

  before do 
    visit root_path
  end
  
  it 'create a new user' do 
    click_link("Sign up")
    fill_in("First name", with: "Bob")
    fill_in("Last name", with: "Fish")
    fill_in("Username", with: "Bobby")
    fill_in("Email",    with: "example@gmail.com")
    fill_in("Password", with: "password")
    fill_in("Password confirmation", with: "password")
    click_button("Sign up")
    expect(current_path).to eq root_path
  end
end