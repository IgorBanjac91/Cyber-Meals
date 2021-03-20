class AddColumnPreparationTimeToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :preparation_time, :integer, default: 12
  end
end
