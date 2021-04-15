class AddColumnStripeProductIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :stripe_product_id, :string
  end
end
