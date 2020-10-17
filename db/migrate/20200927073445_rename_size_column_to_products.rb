class RenameSizeColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :size, :size_id
  end
end
