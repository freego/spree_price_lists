module Spree
  class OrderPopulatorForPriceLists < OrderPopulator
    attr_accessor :price_list

    def initialize(order, price_list)
      @order = order
      @price_list = price_list
      @currency = @price_list.currency
      @errors = ActiveModel::Errors.new(self)
      ensure_order_price_list(order, price_list)
    end

    def valid?
      p errors
      errors.empty?
    end

    private

    def attempt_cart_add(variant_id, quantity)
      quantity = quantity.to_i
      # 2,147,483,647 is crazy.
      # See issue #2695.
      if quantity > 2_147_483_647
        errors.add(:base, Spree.t(:please_enter_reasonable_quantity, scope: :order_populator))
        return false
      end

      variant = Spree::Variant.find(variant_id)
      if quantity > 0
        line_item = @order.contents.add(variant, quantity, price_list)
        unless line_item.valid?
          errors.add(:base, line_item.errors.messages.values.join(" "))
          return false
        end
      end
    end

    def ensure_order_price_list(order, price_list)
      order.update_column(:price_list_id, price_list.id) unless order.price_list_id
    end
  end
end
