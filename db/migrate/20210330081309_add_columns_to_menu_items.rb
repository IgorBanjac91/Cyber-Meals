class AddColumnsToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :menu_items, :item, null: false, foreign_key: true
    add_reference :menu_items, :menu, null: false, foreign_key: true
  end
end
