class AddPreparationTimeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :preparation_time, :integer, dafault: 0
  end
end
