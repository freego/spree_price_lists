module Spree
  module Admin
    ProductsController.class_eval do
      def price_lists
        @product = Product.friendly.find(params[:product_id])
        @price_lists = PriceList.order(:name)
      end
    end
  end
end