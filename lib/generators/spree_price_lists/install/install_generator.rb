module SpreePriceLists
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_javascripts
        # append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_price_lists\n"
        # append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_price_lists\n"
      end

      def add_stylesheets
        # inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_price_lists\n", :before => /\*\//, :verbose => true
        # inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/spree_price_lists\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_price_lists'
      end

      def generate_default_price_list
        puts "=> Generating a default Price List, if none"
        Spree::PriceList.first_or_create!(name: "Default", currency: "EUR")
      end

      def update_prices
        puts "=> Assigning all prices to the first price list"
        Spree::Price.where(price_list_id: nil).update_all(price_list_id: Spree::PriceList.first.id)
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
