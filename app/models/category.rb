class Category < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :items, join_table: :categories_items
end
