class Menu < ApplicationRecord

  before_update :recalculate_menu_attributes

  validates :description, :quantity, :percentage,  presence: true
  validates :items, length: { is: 4 }
    
  has_many :menu_items, dependent: :destroy
  has_many :items, through: :menu_items

  belongs_to :order

  def format_description
    self.description = items.sort.reduce("") { |s, item| s + "#{item.title} + " }[0..-4]
  end

  def calculate_price
    total = 0
    items.each do |item| 
      total += item.price
    end
    self.price = total - (total/100 * self.percentage)
  end

  def sub_total 
    self.price * self.quantity.to_i
  end

  def recalculate_menu_attributes
    format_description
    calculate_price
  end
end
