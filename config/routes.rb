Betastore::Application.routes.draw do

  namespace :admin do
     get '/products'     => 'products#index', as: 'products'
     get '/products/:id' => 'products#show', as: 'product'
  end

  # resources :subscriptions
  get '/products' => 'products#index', as: 'products'

  root :to => 'subscriptions#new'

end
