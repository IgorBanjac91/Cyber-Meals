require 'rails_helper'

RSpec.describe "dashboard/show.html.erb", type: :view do

  let(:order) { ordered_oreder_with_order_itmes }

  before(:each) do 
    @order_items = order.order_items
    assign(:order, order)
    render
  end

  it "renders the order date" do 
    expect(rendered).to have_content(order.creation_date)
  end

  it "renders the purchaser full name and email" do 
    purchaser = order.user 
    expect(rendered).to have_content(purchaser.full_name)
    expect(rendered).to have_content(purchaser.email)
  end

  it "renders all order items names as link to the show page" do 
    @order_items.each do |order_item| 
      expect(rendered).to have_link(order_item.item.title, href: item_path(order_item.item))
    end
  end

  it "renders the quantity, price subtotal of each order item" do 
    @order_items.each do |order_item|  
      expect(rendered).to have_content(order_item.quantity)
      expect(rendered).to have_content(number_to_currency(order_item.item.price))
      expect(rendered).to have_content(order_item.sub_total)
    end
  end

  it "renders the Total price of the order" do 
    expect(rendered).to have_content(order.total_price)
  end

  it "renderd the order status" do 
    expect(rendered).to have_content(order.status)
  end

end
