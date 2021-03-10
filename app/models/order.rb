class Order < ApplicationRecord

  validates :status, presence: true, inclusion: { in: %w(new ordered cancelled completed paid) }

  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  def total_price
    total = order_items.inject(0) { |sum, order_item| sum + order_item.sub_total }
  end

  def creation_date
    created_at.strftime("%d/%m/%Y")
  end
end
