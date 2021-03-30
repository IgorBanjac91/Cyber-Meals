class Order < ApplicationRecord

  validates :status, presence: true, inclusion: { in: %w(new ordered cancelled completed paid) }
  validates :preparation_time, presence: true, if: :status_ordered?

  belongs_to :user, optional: true

  has_many :order_items, dependent: :destroy
  has_many :ordered_items, through: :order_items, source: :item

  has_many :menus

  def total_price
    total = order_items.inject(0) { |sum, order_item| sum + order_item.sub_total }
  end

  def creation_date
    created_at.strftime("%d/%m/%Y")
  end

  def total_order_items 
    order_items.reduce(0) { |sum, order_item| sum + order_item.quantity }
  end

  def time_preparation
    time = self.order_items.reduce(0) do |sum, order_item| 
      sum + ( order_item.item.preparation_time * order_item.quantity )
    end

    if total_order_items / 6 > 0
      return time += ( total_order_items / 6 * 10)
    else
     return time
    end
  end

  def status_ordered? 
    self.status == "ordered"
  end

  def submitted?
    status == "ordered" ? true : false
  end
  
  def new?
    status == "new" ? true : false
  end
end
