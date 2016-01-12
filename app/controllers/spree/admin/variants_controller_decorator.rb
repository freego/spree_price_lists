Spree::Admin::VariantsController.class_eval do
  before_action :build_prices, only: [:new, :edit]

  private

  def build_prices
    Spree::PriceList.where.not(id: price_list_ids).each do |pl|
      @object.prices.build(price_list: pl)
    end
  end

  def price_list_ids
    @object.prices.pluck(:price_list_id)
  end
end
