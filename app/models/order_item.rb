class OrderItem < ApplicationRecord
  
  belongs_to :order
  belongs_to :item

  monetize :sub_total_cents, as: :sub_total

  def sub_total_cents 
    self.item.price * self.quantity.to_i
  end
end
