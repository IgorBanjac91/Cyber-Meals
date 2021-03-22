class AddColumnSaleIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :sale_id, :integer
  end
end
