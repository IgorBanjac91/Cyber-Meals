class Order < ApplicationRecord

  validates :status, presence: true, inclusion: { in: %w(new ordered cancelled completed) }

  belongs_to :user, optional: true
  has_and_belongs_to_many :items
  has_many :order_items, dependent: :destroy

  def total_price
    order_items.inject(0) { |sum, order_item| sum + order_item.sub_total  }
  end
end
