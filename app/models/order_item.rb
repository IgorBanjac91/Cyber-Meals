class OrderItem < ApplicationRecord
  
  belongs_to :order
  belongs_to :item

  monetize :sub_total_cents, as: :sub_total

  def sub_total_cents 
    self.item.price * self.quantity.to_i
  end

  def to_builder
    Jbuilder.new do |order_item|
      order_item.price order_item.item.stripe_price_id
      order_item.quantity quantity
    end
  end
end
