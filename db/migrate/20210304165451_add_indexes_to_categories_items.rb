class AddIndexesToCategoriesItems < ActiveRecord::Migration[6.1]
  def change
    add_index :categories_items, [:category_id, :item_id]
    add_index :categories_items, [:item_id, :category_id]
  end
end
