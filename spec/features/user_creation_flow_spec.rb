require "rails_helper"

RSpec.describe "User creation flow" do 

  before do 
    visit root_path
  end
  
  it 'create a new user' do 
    click_link("Sing up")
    fill_in("Email",    with: "example@gmail.com")
    fill_in("Password", with: "password")
    fill_in("Password confiramtion", with: "password")
    click_button("Sign up")
    expect(current_path).to eq root_path
    expect(page).to have_content("User created successfully")
  end
end