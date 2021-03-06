Rails.application.routes.draw do
  

  root 'sessions#new'

  resources :users
  resources :teachers
  resources :sessions
  resources :prins
  
  get 'student_page' => 'pages#student_page'
  get 'session_destroy' => 'sessions#destroy'
  get 'prin_user' => 'users#prin'
  get 'scheduling' => 'pages#scheduling'
  get 'access' => 'pages#prin'
  get 'teacher_page' =>'pages#teacher_page'
  get 'schedule'=> 'users#schedule'
  get 'teacher_new' =>'teachers#new' 
  get 'reset'=> 'teachers#reset'
  get 'prin_new' => 'prins#new'
  get 'prin_page' => 'users#prin' 
  get 'reset_student_schedule' => 'users#clear_schedule'
  get 'remove_selected' => 'users#remove_selected'
  get 'teacher_remove_selected' => 'teachers#teacher_remove_selected'
  
  post 'auto_create_schedule' =>'users#auto_create_schedule'

  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
