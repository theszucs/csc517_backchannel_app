BackchannelApp::Application.routes.draw do

  # This section can get a little complicated.
  # We had to create nested routing paths so we could call methods in these controllers while in a post
  # or comment view.
  resources :posts do
    resources :comments
    resources :comment_votes
    resources :post_votes
  end
  resources :comments do
    resources :comment_votes
  end
  resources :comment_votes
  resources :categories
  resources :users

  match ':controller(/:action(/:id))(.:format)'
  root :to => 'sessions#login'
  match "signup", :to => 'users#new'
  match "login", :to => 'sessions#login'
  match "logout", :to => 'sessions#logout'
  match "home", :to => 'sessions#home'

  match "/users/revoke_admin/:id", :to => 'users#revoke_admin'
  match "/users/make_admin/:id", :to => 'users#make_admin'

  match "search", :to => 'posts#search'
  match "/search_by_category", :to => 'posts#search_by_category'
  match "/search_by_user", :to => 'posts#search_by_user'
  match "/search_by_content", :to => 'posts#search_by_content'

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
  # match ':controller(/:action(/:id))(.:format)'
end
