class AddPriceAndQuantityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, :decimal
    add_column :products, :quantity, :integer
  end
end
