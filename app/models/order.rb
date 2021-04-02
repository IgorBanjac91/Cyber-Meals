class Order < ApplicationRecord

  scope :with_status, ->(status) { where(status: status) }
  scope :item_title_or_description_with_text, ->(text) { where("items.title like ? OR items.description like ?", "%#{text}%", "%#{text}%") }
  scope :from_user, ->(user_id) { where(user_id: user_id)}

  validates :status, presence: true, inclusion: { in: %w(new ordered cancelled completed paid) }
  validates :preparation_time, presence: true, if: :status_ordered?

  belongs_to :user, optional: true

  has_many :order_items, dependent: :destroy
  has_many :ordered_items, through: :order_items, source: :item

  has_many :menus

  def total_price
    total_items = order_items.inject(0) { |sum, order_item| sum + order_item.sub_total }
    total_menus = menus.inject(0) { |sum, menu| sum + menu.sub_total }
    total = total_items + total_menus
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

  def total_items
    order_items.count + menus.count
  end

  def self.search(params)
    user_id = params[:user_id]
    status = params[:status]
    text = params[:query]
    if params[:status] || params[:query]
      if status
        status == "all" ? Order.from_user(user_id) :
                          Order.from_user(user_id).with_status(status)
      else
        Order.joins(order_items: :item).item_title_or_description_with_text(text).from_user(user_id)
      end
    else
      Order.from_user(user_id)
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
