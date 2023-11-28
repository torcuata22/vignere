Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"
  get "/about", to: "welcome#about"

  resources :vignere, only: [:index]  do
    collection do
      get :encode
      get :decode
      post :decode
    end
  end

  resources :caesar, only: [:index]  do
    collection do
      get :encode
      post :encode
      get :decode
      post :decode
    end
  end
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  post 'vignere/encode', to: 'vignere#encode', as: 'encode_vignere'

end
