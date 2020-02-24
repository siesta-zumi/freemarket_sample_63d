class AddDefaultSellingStatusToItem < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :selling_status, :integer, :default => 0
  end
end
