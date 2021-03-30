class AddColumnToMenus < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :order_id, :integer
  end
end
