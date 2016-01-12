module Spree
  Product.class_eval do
    delegate_belongs_to :master, :price_for

    accepts_nested_attributes_for :master

    def variants_and_option_values_for_price_list(current_price_list = nil)
      variants.includes(:option_values)
              .active_for_price_list(current_price_list)
              .select do |variant|
        variant.option_values.any?
      end
    end
  end
end
