class ChangeColumnTypeFromItem < ActiveRecord::Migration[6.1]
  def up
    change_column :items, :price, :decimal, :precision => 8, :scale => 2
  end
  
  def down
    change_column :items, :price, :decimal
  end
end
