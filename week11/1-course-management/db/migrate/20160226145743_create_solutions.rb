class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :text_block, null: false
      t.belongs_to :task, index: true
      t.timestamps null: false
    end
  end
end
