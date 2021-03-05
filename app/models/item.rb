class Item < ApplicationRecord

  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than: 0}
  validates :categories, presence: true

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :orders
  has_many :order_items
end
