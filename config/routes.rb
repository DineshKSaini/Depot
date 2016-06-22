Depot::Application.routes.draw do
  #devise_for :members
  devise_scope :user do
  get 'login', to: 'devise/sessions#new'
  delete 'logout ',to: 'devise/sessions#destroy'
end
  devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' end
 # devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
    #devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :reviews

  resources :categories

  get 'admin' => 'admin#index'

  
  # controller :sessions do
  #   get 'login' => :new
  #   post 'login' => :create
  #   delete 'logout' => :destroy
  # end
  #root to: 'home#index'
  #match 'logout', to: 'users#sign_out', :as=>:logout , via: [:get, :post]
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  root to: 'store#index', as: 'store'

  #get "sessions/new"

  #get "sessions/create"

  #get "sessions/destroy"


  resources :users

  resources :orders

  resources :line_items

  resources :carts

  get "store/index"

  resources :products do
    resources :reviews
    member do
      get :who_bought
    end
  end
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
