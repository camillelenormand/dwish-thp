class AddPaymentOrderToCart < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :payment_order_id, :string
  end
end
