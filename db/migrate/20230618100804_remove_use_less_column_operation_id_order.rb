class RemoveUseLessColumnOperationIdOrder < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :operation_id_paygreen
  end
end
