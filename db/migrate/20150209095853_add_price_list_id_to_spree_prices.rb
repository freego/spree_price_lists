class AddPriceListIdToSpreePrices < ActiveRecord::Migration
  def change
    add_column :spree_prices, :price_list_id, :integer
  end
end
