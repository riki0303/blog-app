Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'articles#index'


  resources :articles do 
    resources :comments, only: [:new, :create]
  end

  # profileは1つのため単数,indexが作成されない
  resource :profile, only: [:show, :edit, :update]
end
