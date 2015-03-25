module Spree
  class Order < Spree::Base
    module PriceListUpdater
      extend ActiveSupport::Concern

      included do
        def homogenize_line_item_price_list
          update_line_item_price_lists!
          update!
        end
      end

      # Updates prices of order's line items
      def update_line_item_price_lists!
        line_items.where('price_list_id != ?', price_list_id).each do |line_item|
          update_line_item_price!(line_item)
        end
      end

      # Returns the price object from given item
      def price_from_line_item(line_item)
        line_item.variant.price_for(price_list)
      end

      # Updates price from given line item
      def update_line_item_price!(line_item)
        price = price_from_line_item(line_item)

        if price
          line_item.update_attributes!(price_list_id: price.price_list_id, price: price.amount)
        else
          raise RuntimeError, "no #{price_list.name} list price found for #{line_item.product.name} (#{line_item.variant.sku})"
        end
      end

    end
  end
end
