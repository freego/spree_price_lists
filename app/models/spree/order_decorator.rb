module Spree
  Order.class_eval do
    include Spree::Order::PriceListUpdater

    belongs_to :price_list

    before_validation :set_price_list
    before_update :homogenize_line_item_price_list, if: :price_list_id_changed?

    private

    # override
    def set_currency
      self.currency = price_list.try(:currency) || Spree::Config[:currency]
    end

    def set_price_list
      self.price_list ||= PriceList.first
    end
  end
end
