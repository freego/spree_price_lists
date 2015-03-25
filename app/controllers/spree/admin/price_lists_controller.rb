module Spree
  module Admin
    class PriceListsController < ResourceController
      def index
        @price_lists = Spree::PriceList.page(params[:page] || 1).per(50)
      end
    end
  end
end