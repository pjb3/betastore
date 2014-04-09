Betastore::Application.routes.draw do

  get '/fail' => 'fail#fail'

  namespace :admin do
    resources :products
    get  '/login' => 'logins#new', as: 'logins'
    post '/login' => 'logins#create'
  end

  resources :subscriptions
  get '/products' => 'products#index', as: 'products'

  root :to => 'subscriptions#new'

end
