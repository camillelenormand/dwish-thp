class AddExternalIdFromZelty < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :zelty_id, :string
    add_column :categories, :zelty_id, :string
    add_column :orders, :zelty_id, :string
    add_column :users, :zelty_id, :string
    add_column :users, :paygreen_id, :string
  end
end
