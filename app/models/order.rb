class Order < ApplicationRecord

  validates :user, presence: true

  belongs_to :user
  has_and_belongs_to_many :items
end
