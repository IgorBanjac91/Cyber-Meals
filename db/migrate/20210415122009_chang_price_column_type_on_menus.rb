class ChangPriceColumnTypeOnMenus < ActiveRecord::Migration[6.1]
  def change
    change_column :menus, :price, :integer
  end
end
