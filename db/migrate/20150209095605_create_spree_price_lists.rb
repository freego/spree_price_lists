class CreateSpreePriceLists < ActiveRecord::Migration
  def self.up
    create_table :spree_price_lists do |t|
      t.string :name, null: false
      t.string :internal_name, null: false
      t.string :currency, null: false
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_price_lists
  end
end