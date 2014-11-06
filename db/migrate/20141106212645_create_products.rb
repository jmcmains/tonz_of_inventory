class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku
      t.float :wholesale_price
      t.integer :inventory

      t.timestamps
    end
  end
end
