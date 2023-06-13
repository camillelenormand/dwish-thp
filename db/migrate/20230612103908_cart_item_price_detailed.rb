class CartItemPriceDetailed < ActiveRecord::Migration[7.1]
  def change
    change_column :cart_items, :price, :decimal, precision: 10, scale: 2
  end
end
