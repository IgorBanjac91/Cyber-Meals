class DropJoinTableItmesProducts < ActiveRecord::Migration[6.1]
  def change
    drop_join_table(:items, :orders)
  end
end
