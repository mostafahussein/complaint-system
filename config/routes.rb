SweComplaint::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => 'users' }
   resources :users, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
     collection do
       get :users_directory
     end
   end
   
   resources :activities

   resources :students do
     collection do
       post :create_multiple
     end
   end

   resources :employees do
     collection do
       post :create_multiple
     end
   end
   
   resources :advisors, controller: 'employees'
   resources :staffs, controller: 'employees'

   resources :tickets do
     resources :follow_ups
     put :assign , on: :member
     collection do
       get :total_tickets
       get :open_status
       get :in_progress_status
       get :pending_status
       get :solved_status
       get :closed_status
       get :high_tickets
       get :normal_tickets
       get :low_tickets
     end
   end

   resources :subjects do
     resources :tickets
     collection do
       get :assign_advisors
       put :update_multiple
     end
   end
   
   resources :subject_staffs
   
   resources :kbs
   resources :responses
   
   get '/dashboard', to: 'dashboard#index', as: :dashboard

   devise_scope :user do
     root to: 'devise/sessions#new'
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
  # match ':controller(/:action(/:id))(.:format)'
end
