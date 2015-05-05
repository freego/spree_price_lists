module Spree
  OrderContents.class_eval do
    private

    def add_to_line_item(variant, quantity, options = {})
      line_item = grab_line_item_by_variant(variant, false, options)
      price_list = order.price_list

      if line_item
        line_item.quantity += quantity.to_i
        line_item.currency = order.currency
        line_item.price_list = price_list
      else
        base_opts = { currency: order.currency,
                      price_list: price_list }
        opts = base_opts.merge ActionController::Parameters.new(options).
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