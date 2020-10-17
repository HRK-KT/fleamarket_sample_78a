class RenameProductStatusColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :product_status, :product_status_id
  end
end
