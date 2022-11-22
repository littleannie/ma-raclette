Rails.application.routes.draw do
  devise_for :users
  root to: "raclettes#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :raclettes do
    resources :bookings, except: [:destroy]
    resources :reviews, except: [:index, :show, :destroy]
  end
  resources :reviews, only: [:destroy]
end
