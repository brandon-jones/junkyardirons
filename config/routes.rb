Rails.application.routes.draw do
  resources :images

  resources :machine_sets do 
    resources :machines
  end

  get 'machines/new_form', to: 'machines#new_form'

  devise_for :users
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

  root to: 'static_pages#home'

  get 'admin', to: 'admin#index'
  post 'admin/update_signup_status', to: 'admin#update_signup_status'

  namespace 'about_my_machines' do
    get 'show'
    get 'edit'
    post 'update'
  end

  namespace 'instagram' do
    get 'edit_user'
    post 'search_user'
    post 'update_user'
    get 'edit_tags'
    post 'update_tags'
    get 'images/:user_id', to: '#get_images'
    get 'remove_images'
  end

  delete 'instagram/:image_id', to: 'instagram#destroy'
  # get 'about_my_machines', to: 'about_my_machines#show'
  # get 'about_my_machines/edit', to: 'about_my_machines#edit'
  # post 'about_my_machines/update', to: 'about_my_machines#update'

  # get 'instagram/edit_user', to: 'instagram#edit_user'
  # post 'instagram/search_user', to: 'instagram#search_user'
  # post 'instagram/update_user', to: 'instagram#update_user'

  # get 'instagram/edit_tags', to: 'instagram#edit_tags'
  # post 'instagram/update_tags', to: 'instagram#update_tags'
  # get 'instagram_images/:user_id', to: 'instagram#get_images'
end
