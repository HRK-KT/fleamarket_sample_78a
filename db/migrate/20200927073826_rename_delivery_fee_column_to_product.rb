class RenameDeliveryFeeColumnToProduct < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :delivery_fee, :delivery_fee_id
  end
end
