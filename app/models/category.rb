class Category < ApplicationRecord

  validates :name, :items, presence: true

  has_and_belongs_to_many :items, join_table: :categories_items
end
