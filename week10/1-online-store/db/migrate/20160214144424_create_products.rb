class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :brand, null: false
      t.string :category, null:false

      t.timestamps null: false
    end
  end
end
