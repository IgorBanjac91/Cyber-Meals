class Item < ApplicationRecord

  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than: 0}
  validates :categories, presence: true

  has_many :categorizations
  has_many :categories, through: :categorizations
  
  has_many :order_items
end
