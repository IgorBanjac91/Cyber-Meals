class AddColumnSaleIdToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :sale_id, :integer
  end
end
