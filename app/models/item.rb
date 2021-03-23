class Item < ApplicationRecord

  validates :title, :description, :price, :preparation_time,  presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than: 0}

  has_many :categorizations
  has_many :categories, through: :categorizations
  
  has_many :order_items

  belongs_to :sale

  mount_uploader :image, ImageUploader

  has_many :reviews 
  has_many :users, through: :reviews

  def on_sale?
    sale ? true : false
  end

  def discounted_price
    if self.on_sale?
      discount = sale.discount
      new_price = price - ( price / 100 * discount )
      return new_price
    else
      return nil
    end
  end
end
