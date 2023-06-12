class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :status, null: false, default: 0
      t.string :operation_id_paygreen, null: false, index: { unique: true }
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true
      t.belongs_to :cart, foreign_key: true
      t.timestamps
    end
  end
end
