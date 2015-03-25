class AddDefaultToSpreePriceList < ActiveRecord::Migration
  def change
    add_column :spree_price_lists, :default, :boolean, default: false
  end
end
