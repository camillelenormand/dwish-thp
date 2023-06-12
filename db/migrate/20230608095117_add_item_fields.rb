class AddItemFields < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :name, :string
    add_column :items, :description, :string
    add_column :items, :price, :decimal, precision: 10, scale: 2
    add_reference :items, :category, foreign_key: true
    add_column :items, :image_url, :string
    add_column :items, :quantity, :integer, default: 0
    add_column :items, :status, :integer, default: 0
  end
end
