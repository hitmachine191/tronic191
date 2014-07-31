Rails.application.routes.draw do
  #root to: "sessions#new"

  #get "/api", to: "static_pages#root"

  root to: "static_pages#root"

  #TODO limit to used actions
  resources :users
  resource :session
#   resources :albums do
#     resource :share, only: [:new, :create]
#     collection do
#       get 'public'
#     end
#     resources :photos, only: [:new, :create] #rename route this to /albums/:id/upload
#   end
#
#   resources :photos, only: [:show, :edit, :update, :destroy, :index] do
#     resources :comments, only: [:create]
#     resource :likes, only: [:create, :destroy]
#   end
#
#   resources :tags, only: [:index, :show, :destroy]
#
#   resources :comments, only: [:destroy] # maybe add edit with js
#
  resources :notifications, only: [:index, :show]

  get 'auth/google_oauth2/callback', to: "sessions#google"


  namespace :api, defaults: {format: 'json'} do
    resources :users, only: [:show]
    resources :photos, only: [:show, :update, :destroy, :index, :create] do
      resources :comments, only: [:index]
      resource :likes, only: [:create, :destroy] # maybe add index of photos you like
    end
    resources :comments, only: [:destroy, :show, :create, :destroy] # maybe add edit with js

    resources :albums do
      resource :share, only: [:create]
      collection do
        get 'public'
      end
    end

    resources :tags, only: [:index, :show, :destroy]
  end



end
