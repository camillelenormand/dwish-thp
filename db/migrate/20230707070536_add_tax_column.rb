class AddTaxColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :tax, :integer
    add_column :items, :disable, :boolean
  end
end
