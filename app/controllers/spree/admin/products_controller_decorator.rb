Spree::Admin::ProductsController.class_eval do
  before_action :build_prices, only: [:edit]

  def price_lists
    @product = Spree::Product.friendly.find(params[:product_id])
    @price_lists = Spree::PriceList.order(:name)
  end

  private

  def build_prices
    Spree::PriceList.where.not(id: price_list_ids).each do |pl|
      @object.master.prices.build(price_list: pl) unless pl.default?
    end
  end

  def price_list_ids
    @object.master.prices.pluck(:price_list_id)
  end
end
