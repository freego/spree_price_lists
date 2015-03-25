module Spree
  LineItem.class_eval do
    belongs_to :price_list

    validate :ensure_proper_price_list

    private

    def ensure_proper_price_list
      unless price_list_id == order.price_list_id
        errors.add(:price_list, :must_match_price_list)
      end
    end
  end
end
