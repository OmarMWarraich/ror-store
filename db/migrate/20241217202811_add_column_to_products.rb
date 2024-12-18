class AddColumnToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :price, :float, default: 0.0, null: false
    add_column :products, :description, :text, null: false
  end
end
