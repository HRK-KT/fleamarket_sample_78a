class RenameDeliveryTimeColumnToProduct < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :delivery_time, :delivery_time_id
  end
end
