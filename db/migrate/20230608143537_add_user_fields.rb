class AddUserFields < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name,  :string
    add_column :users, :phone,      :string
    add_column :users, :is_admin,   :boolean, default: false
    add_column :users, :is_active,  :boolean, default: true
    add_column :users, :is_deleted, :boolean, default: false
  end
end
