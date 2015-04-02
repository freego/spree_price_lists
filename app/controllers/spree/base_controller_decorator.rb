module Spree
  BaseController.class_eval do
    helper_method :current_price_list

    def current_price_list
      @current_price_list ||= price_list_or_default
    end

    def current_currency
      current_price_list.currency
    end

    private

    # override this with custom logic
    def get_price_list
    end

    def price_list_or_default
      price_list = get_price_list || PriceList.default
      logger.debug("=> setting current price list to #{price_list.id}")
      price_list
    end
  end
end
