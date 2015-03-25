module Spree
  class PriceList < ActiveRecord::Base
    has_many :prices

    validates :name, :internal_name, :currency,
      presence: true
    validates :default, uniqueness: true, if: :default

    before_validation :set_internal_name
    before_validation :set_default_currency

    scope :by_currency, ->(currency) { where(currency: currency) }
    scope :without_default_list, -> { where.not(default: true) }

    def self.default
      find_by(default: true) || first || create!(name: "Default", default: true)
    end

    private

    def set_internal_name
      self.internal_name = name.downcase.gsub(" ", "_") if internal_name.blank?
    end

    def set_default_currency
      self.currency ||= Spree::Config.currency
    end
  end
end