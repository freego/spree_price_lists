FactoryGirl.define do
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_price_lists/factories'

  factory :price_list, class: Spree::PriceList do
    name "Default"
    currency "EUR"
  end
end
