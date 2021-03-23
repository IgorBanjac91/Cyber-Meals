class Sale < ApplicationRecord

  validates :title, :discount, presence: true
  validates :discount, numericality: { only_integer: true, 
                                       greater_than_or_equal_to: 0, 
                                       less_than_or_equal_to: 100 }

  has_many :categories
  has_many :items
end
