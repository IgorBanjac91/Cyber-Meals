class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.integer :quantity
      t.text :description
      t.integer :percentage, default: 10

      t.timestamps
    end
  end
end
