module Spree
  LineItem.class_eval do
    belongs_to :price_list

    validate :ensure_proper_price_list

    def options=(options={})
      return unless options.present?

      opts = options.dup # we will be deleting from the hash, so leave the caller's copy intact

      price_list = opts.delete(:price_list)

      if price_list
        self.price_list = price_list
        self.currency   = price_list.currency
        self.price      = variant.price_for(price_list).amount +
                          variant.price_modifier_amount_in(price_list.currency, opts)
      else
        self.price    = variant.price +
                        variant.price_modifier_amount(opts)
      end

      self.assign_attributes opts
    end

    private

    def ensure_proper_price_list
      unless price_list_id == order.price_list_id
        errors.add(:price_list, :must_match_price_list)
      end
    end
  end
end
