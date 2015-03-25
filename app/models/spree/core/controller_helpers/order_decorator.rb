module Spree
  module Core
    module ControllerHelpers
      Order.module_eval do
        def current_order_params
          { currency: current_currency,
            guest_token: cookies.signed[:guest_token],
            user_id: try_spree_current_user.try(:id),
            price_list_id: current_price_list.id }
        end
      end
    end
  end
end
