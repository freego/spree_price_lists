module Spree
  OrderContents.class_eval do
    def add(variant, quantity = 1, price_list = nil, shipment = nil)
      line_item = add_to_line_item(variant, quantity, price_list, shipment)
      reload_totals
      shipment.present? ? shipment.update_amounts : order.ensure_updated_shipments
      PromotionHandler::Cart.new(order, line_item).activate
      ItemAdjustments.new(line_item).update
      reload_totals
      line_item
    end

    private

    def add_to_line_item(variant, quantity, price_list = nil, shipment = nil)
      line_item = grab_line_item_by_variant(variant)

      if line_item
        line_item.target_shipment = shipment
        line_item.quantity += quantity.to_i
        line_item.currency = price_list.currency if price_list
        line_item.price_list = price_list
      else
        line_item = order.line_items.new(quantity: quantity, variant: variant)
        line_item.target_shipment = shipment
        if price_list
          line_item.currency   = price_list.currency
          line_item.price      = variant.price_for(price_list).amount
          line_item.price_list = price_list
        else
          line_item.price    = variant.price
        end
      end

      line_item.save
      line_item
    end
  end
end