class CartItemQuantityDetailed < ActiveRecord::Migration[7.1]
  def change
    change_column :cart_items, :quantity, :integer, default: 1
  end
end
