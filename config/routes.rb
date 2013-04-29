StoreEngine::Application.routes.draw do

  resources :static_pages, :only => :index
  resources :users, :except => [:index, :destroy, :show]
  resources :billing_address
  resources :shipping_address
  resources :sessions, :only => [:new, :create, :destroy]
  resources :stores, :only => [:index, :create]
  resources :products, :only => [:index, :show]

  resources :auctions, :only => [:index, :show] do
    resources :bids, :only =>   [:create]
  end

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'
  get 'create_new_store', to: 'stores#new', as: 'create_new_store'

  get 'profile', :to => 'users#show', as: 'profile'
  get 'profile/orders', :to => 'orders#index', as: 'profile_orders'
  get 'profile/edit', :to => 'users#edit', as: 'edit_profile'



  namespace :admin do
    get "/", to: "stores#index", as: 'home'
    resources :stores
  end

  scope "/:store_id" do

    #get "/", to: "products#index", :as => :store_home
    #match "/" => "products#index", :as => :home

    match 'checkout' => 'orders#new', as: 'checkout'
    match 'checkout/type' => 'orders#type', as: 'checkout_type'

    resources :orders, :except => [:edit, :update, :destroy]

    resources :categories, :only => [:index, :show]

    namespace :store_admin, :path => "/admin" do
      match "/" => "dashboards#show"
      resources :products, :except => :destroy
      resources :members
      resources :categories, :except => :show
      resources :stores, :only => [:index, :edit, :update]
      resources :orders, :except => :destroy
    end

  end

  root :to => 'static_pages#index'

end
