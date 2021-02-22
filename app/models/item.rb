class Item < ApplicationRecord

  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than: 0}

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :orders
end
