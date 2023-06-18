class AddTotalAmountCart < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :total_amount, :decimal, precision: 10, scale: 2
  end
end
