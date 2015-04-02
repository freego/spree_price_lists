module Spree
  OrderContents.class_eval do
    private

    def add_to_line_item(variant, quantity, options = {})
      price_list = options[:price_list]
      line_item = grab_line_item_by_variant(variant, false, options)

      if line_item
        line_item.quantity += quantity.to_i
        line_item.currency = price_list.currency if price_list
        line_item.price_list = price_list
      else
        opts = { currency: order.currency,
                 price_list: price_list}.merge ActionController::Parameters.new(options).
                                         permit(PermittedAttributes.line_item_attributes)
        line_item = order.line_items.new(quantity: quantity,
                                          variant: variant,
                                          options: opts)
      end
      line_item.target_shipment = options[:shipment] if options.has_key? :shipment
      line_item.save!
      line_item
    end

  end
end