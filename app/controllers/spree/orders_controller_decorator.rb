module Spree
  OrdersController.class_eval do
    def populate
      populator = Spree::OrderPopulatorForPriceLists.new(current_order(create_order_if_necessary: true), current_price_list)

      if populator.populate(params[:variant_id], params[:quantity], params[:options])
        respond_with(@order) do |format|
          format.html { redirect_to cart_path }
        end
      else
        flash[:error] = populator.errors.full_messages.join(" ")
        redirect_back_or_default(spree.root_path)
      end
    end
  end
end