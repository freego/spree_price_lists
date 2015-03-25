class AddPriceListIdToLineItemsAndOrder < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :price_list_id, :integer
    add_column :spree_orders, :price_list_id, :integer
  end
end
