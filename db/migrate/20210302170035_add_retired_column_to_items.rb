class AddRetiredColumnToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :retired, :boolean, default: false
  end
end
