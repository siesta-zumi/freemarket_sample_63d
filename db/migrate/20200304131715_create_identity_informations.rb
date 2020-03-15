class CreateIdentityInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :identity_informations do |t|
      t.references :user,             null: false, foreign_key: true
      t.string :first_name,           null: false
      t.string :last_name,            null: false
      t.string :first_name_furigana,  null: false
      t.string :last_name_furigana,   null: false
      t.date   :birthday,             null: false

      t.timestamps
    end
  end
end
