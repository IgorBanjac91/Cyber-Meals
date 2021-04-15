class AddColumnStripePriceIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :stripe_price_id, :string
  end
end
