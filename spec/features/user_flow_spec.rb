require "rails_helper"

RSpec.describe "User flow", type: :feature do 

  before do 
    @items = create_list(:items)
    visit root_page
  end

  context "Unauthanticated User" do 

    it 'can see all items on the page' do 
     @items.each do |item|
       expect(page).to have_content(item.title)
     end 
    end
  end
end