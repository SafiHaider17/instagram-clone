Rails.application.routes.draw do
  devise_for :users
  
  # Routes for posts and comments
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  
  # Chatrooms routes
  resources :chatrooms
  resources :messages

  # About page route
  get '/about', to: "pages#about"

  # Define the root path route for unauthenticated users
  root "posts#index"

  # Define the authenticated root path route for logged-in users
  authenticated :user do
    root to: 'posts#index', as: :authenticated_user_root
  end
end
