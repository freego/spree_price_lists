module Spree
  UserRegistrationsController.class_eval do
    include Spree::Core::ControllerHelpers::PriceList
  end
end
