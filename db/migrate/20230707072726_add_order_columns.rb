class AddOrderColumns < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :due_date, :datetime
    add_column :orders, :mode, :string, default: "takeaway"
    add_column :orders, :source, :string, default: "web"
    add_column :orders, :user_email, :string
  end
end
