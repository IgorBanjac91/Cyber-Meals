class RemoveColumnFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :item_id, :integer
  end
end
