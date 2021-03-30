class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item


  def sub_total 
    self.item.price * self.quantity.to_i
  end
end
