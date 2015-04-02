module Spree
  class OrderPopulatorForPriceLists < OrderPopulator
    attr_accessor :price_list

    def initialize(order, price_list)
      @order = order
      @price_list = price_list
      @currency = @price_list.currency
      @errors = ActiveModel::Errors.new(self)
    end

    def populate(variant_id, quantity, options = {})
      ActiveSupport::Deprecation.warn "OrderPopulator is deprecated and will be removed from Spree 3, use OrderContents with order.contents.add instead.", caller
      # protect against passing a nil hash being passed in
      # due to an empty params[:options]
      attempt_cart_add(variant_id, quantity, (options || {}).merge({ price_list: price_list }))
      valid?
    end
  end
end
