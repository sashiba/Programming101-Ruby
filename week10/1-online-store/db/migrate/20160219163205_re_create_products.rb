class ReCreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :brand_id
      t.integer :category_id
      t.decimal :price, null: false
      t.integer :quantity, null: false
      t.timestamps null: false
    end

    add_index :products, :brand_id
    add_index :products, :category_id
  end
end
