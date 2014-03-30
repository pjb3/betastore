Betastore::Application.routes.draw do

  namespace :admin do
    resources :products
  end

  resources :subscriptions
  get '/products' => 'products#index', as: 'products'

  root :to => 'subscriptions#new'

end
