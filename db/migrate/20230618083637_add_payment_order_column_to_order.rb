class AddPaymentOrderColumnToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :payment_order_id, :string
  end
end
