Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"
  get 'vignere/index'
  get 'vignere/encode'
  get 'vignere/decode'
end
