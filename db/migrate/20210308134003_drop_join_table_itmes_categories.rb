class DropJoinTableItmesCategories < ActiveRecord::Migration[6.1]
  def change
    drop_join_table(:items, :categories)
  end
end
