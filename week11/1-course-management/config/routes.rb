Rails.application.routes.draw do

  resources :lectures do
    resources :tasks do
      resources :solutions
    end
  end
  # lectures
 # get 'lectures', to: 'lectures#index'
 # get 'lectures/new', to: 'lectures#new'
 # get 'lectures/:id', to: 'lectures#show', as: :lecture
 # get 'lectures/:id/edit', to: 'lectures#edit', as: :edit_lecture
 # post 'lectures', to: 'lectures#create'
 # delete 'lectures/:id', to: 'lectures#destroy'
 # put 'lectures/:id', to: 'lectures#update'
 # patch 'lectures/:id', to: 'lectures#update'

  # tasks -- task_id? lecture_id..id
 # get 'lectures/:lecture_id/tasks', to: 'tasks#index', as: :tasks
 # get 'lectures/:lecture_id/tasks/new', to: 'tasks#new', as: :tasks_new
 # get 'lectures/:lecture_id/tasks/:id', to: 'tasks#show', as: :task
 # get 'lectures/:lecture_id/tasks/:id/edit', to: 'tasks#edit', as: :edit_task
 # post 'lectures/:lecture_id/tasks', to: 'tasks#create'
 # delete 'lectures/:lecture_id/tasks/:id', to: 'tasks#destroy'
 # put 'lectures/:lecture_id/tasks/:id', to: 'tasks#update'
 # patch 'lectures/:lecture_id/tasks/:id', to: 'tasks#update'
 # 

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
