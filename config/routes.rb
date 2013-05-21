Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :products do
      resources :cart_discounts
    end
    resources :levels
  end
end
