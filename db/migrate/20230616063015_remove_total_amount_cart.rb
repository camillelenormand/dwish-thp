class RemoveTotalAmountCart < ActiveRecord::Migration[7.1]
  def change
    remove_column :carts, :total_amount
  end
end
