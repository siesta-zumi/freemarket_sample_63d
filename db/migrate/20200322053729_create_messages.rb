class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false
      t.text :message, null: false
      t.integer :purchase_phase
      t.timestamps
    end
  end
end
