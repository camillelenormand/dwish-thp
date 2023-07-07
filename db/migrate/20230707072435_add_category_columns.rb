class AddCategoryColumns < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :description, :text
    add_column :categories, :image_url, :string
  end
end
