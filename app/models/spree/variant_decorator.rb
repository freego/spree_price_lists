module Spree
  Variant.class_eval do

    accepts_nested_attributes_for :prices

    has_one :default_price,
      -> { where price_list_id: Spree::PriceList.default.id },
      class_name: 'Spree::Price',
      dependent: :destroy,
      inverse_of: :variant

    def price_for(price_list)
      prices.select do |price|
        price.price_list_id == price_list.id
      end.first || Spree::Price.new(variant_id: self.id, currency: Spree::Config[:currency])
    end

    def self.active_for_price_list(price_list = nil)
      price_list_id = price_list ? price_list.id : Spree::PriceList.default.id
      joins(:prices).where(deleted_at: nil)
                    .where('spree_prices.price_list_id' => price_list_id)
                    .where('spree_prices.amount IS NOT NULL')
    end

  end
end
