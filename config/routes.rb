Betastore::Application.routes.draw do

  get  '/sign_up' => 'customers#new', as: 'sign_up'
  post '/sign_up' => 'customers#create'

  get  '/verify/:token' => 'customers#verify', as: 'verify_customer'

  get '/fail' => 'fail#fail'

  namespace :admin do
    resources :products
    get  '/login' => 'logins#new', as: 'logins'
    post '/login' => 'logins#create'
  end

  resources :subscriptions
  get '/products'    => 'products#index', as: 'products'
  get '/product/:id' => 'products#show',  as: 'product'

  root 'products#index'

end
