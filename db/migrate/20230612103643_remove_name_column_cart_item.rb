class RemoveNameColumnCartItem < ActiveRecord::Migration[7.1]
  def change
    remove_column :cart_items, :name
  end
end
