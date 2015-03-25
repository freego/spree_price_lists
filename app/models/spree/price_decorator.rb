module Spree
  Price.class_eval do
    belongs_to :price_list

    before_validation :ensure_price_list
    validates :price_list_id, presence: true

    private

    def ensure_price_list
      self.price_list_id ||= PriceList.default.id if variant.prices.none?
    end
  end
end