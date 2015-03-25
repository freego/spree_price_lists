Spree::Core::Engine.routes.draw do
  # Add your extension routes here
end

Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :price_lists do
      collection do
        post :update_positions
      end
    end

    resources :products do
      get :price_lists
    end
  end
end
