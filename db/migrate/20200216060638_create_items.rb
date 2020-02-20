class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                   null: false
      t.text :description,              null: false
      t.integer :status,                null: false
      t.integer :is_bear_shipping_cost, null: false
      t.integer :region,                null: false
      t.integer :period,                null: false
      t.integer :price,                 null: false
      t.integer :selling_status,        null: false
      t.references :user,               null: false, foreign_key: true
      t.references :category,           null: false, foreign_key: true
      t.references :brand,              null: false, foreign_key: true
      t.timestamps
    end
  end
end
