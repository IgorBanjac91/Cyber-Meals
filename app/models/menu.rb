class Menu < ApplicationRecord

  validates :description, :quantity, :percentage,  presence: true
  validates :items, length: { is: 4 }
    
  has_many :menu_items
  has_many :items, through: :menu_items

  belongs_to :order

  def format_description
    self.description = items.sort.reduce("") { |s, item| s + "#{item.title} + " }[0..-4]
  end

  def calculate_price
    total = 0
    items.each do |item| 
      total += item.price
      pp item.price
    end
    self.price = total - (total/100 * self.percentage)
  end

  def sub_total 
    self.price * self.quantity.to_i
  end
end
