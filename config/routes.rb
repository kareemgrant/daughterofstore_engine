StoreEngine::Application.routes.draw do


  resources :static_pages, :only => :index

  resources :users, :except => [:index, :destroy, :show]
  resources :consumers, :except => [:index, :destroy]
  resources :billing_address
  resources :shipping_address
  resources :phone_numbers
  resources :sessions, :only => [:new, :create, :destroy]
  resources :stores, :only => [:index, :create]

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'create_new_store', to: 'stores#new', as: 'create_new_store'

  get 'profile', :to => 'users#show', as: 'profile'
  get 'profile/orders', :to => 'orders#index', as: 'profile_orders'
  get 'profile/edit', :to => 'users#edit', as: 'edit_profile'



  namespace :admin do
    resources :stores
    resources :line_items, :only => [] do
      put 'increase_quantity', :on => :member
      put 'decrease_quantity', :on => :member
    end
  end

  match 'guest_order/:random' => 'orders#show_guest_order', as: 'guest_order'

  scope "/:store_id" do

    get "/", to: "products#index", :as => :store_home
    match "/" => "products#index", :as => :home

    match 'checkout' => 'orders#new', as: 'checkout'
    match 'checkout/type' => 'orders#type', as: 'checkout_type'


    resources :products, :only => [:index, :show]
    resources :orders, :except => [:edit, :update, :destroy]
    resources :line_items

    resources :carts do
        put 'increase_quantity', :on => :member
        put 'decrease_quantity', :on => :member
    end



    resources :categories, :only => [:index, :show]

    namespace :store_admin, :path => "/admin" do
      match "/" => "dashboards#show"
      # resource :dashboard, :only => :show
      resources :products, :except => :destroy
      resources :members
      resources :categories, :except => :show
      resources :stores, :only => [:index, :edit, :update]

      resources :orders, :except => :destroy do
        put 'increase_quantity', :on => :member
        put 'decrease_quantity', :on => :member
      end
      
      # match "/edit" => "dashboards#edit"

      put '/add_quantity_to_order/:id' => 'orders#add_quantity_to_order', :as => 'add_quantity_to_order'
      put '/decrease_quantity_from_order/:id' => 'orders#decrease_quantity_from_order', :as => 'decrease_quantity_from_order'
    end

  end

  root :to => 'static_pages#index'

end
