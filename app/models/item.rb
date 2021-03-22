class Item < ApplicationRecord

  validates :title, :description, :price, :preparation_time,  presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than: 0}

  has_many :categorizations
  has_many :categories, through: :categorizations
  
  has_many :order_items

  belongs_to :sale

  mount_uploader :image, ImageUploader
end
