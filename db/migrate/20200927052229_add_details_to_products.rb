class AddDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_detail, :text, null:false
  end
end
