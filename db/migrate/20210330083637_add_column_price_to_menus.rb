class AddColumnPriceToMenus < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :price, :decimal, :precision => 8, :scale => 2
  end
end
