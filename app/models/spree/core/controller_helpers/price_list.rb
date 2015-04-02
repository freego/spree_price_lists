module Spree
  module Core
    module ControllerHelpers
      module PriceList
        extend ActiveSupport::Concern

        included do
          helper_method :current_price_list
        end

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
          price_list = get_price_list || Spree::PriceList.default
          logger.debug("=> setting current price list to #{price_list.id}")
          price_list
        end

      end
    end
  end
end
