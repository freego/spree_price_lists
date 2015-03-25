module Spree
  ApplicationController.class_eval do
    helper_method :current_price_list, :current_currency

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
      if session[:current_price_list_id]
        return PriceList.find_by(id: session[:current_price_list_id])
      else
        price_list = get_price_list || PriceList.default
        session[:current_price_list_id] = price_list.id
        logger.debug("=> setting current price list to #{price_list.id}")
        price_list
      end
    end

  end
end