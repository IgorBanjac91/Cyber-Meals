class RemoveOrderIdColumnFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :order_id, :integer
  end
end
