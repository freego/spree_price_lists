module Spree
  BaseHelper.class_eval do
    def display_price(product_or_variant)
      product_or_variant.price_for(current_price_list).display_price.to_html
    end
  end
end