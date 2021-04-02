class Item < ApplicationRecord

  scope :with_title, ->(title) { where(title: title) }
  

  validates :title, :description, :price, :preparation_time,  presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than: 0}

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  
  has_many :order_items
  has_many :orders, through: :order_items

  belongs_to :sale, optional: true

  mount_uploader :image, ImageUploader

  has_many :reviews
  has_many :users, through: :reviews

  has_many :menu_items
  has_many :menus, through: :menu_items

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

  def self.search(query)
    if query
      @item = self.with_title(query)
      unless @item.empty?
        @item
      else
       Item.all
      end
    else
     Item.all
    end
  end
end
