Rails.application.routes.draw do
  devise_for :users
  as :user do
    get 'users', :to => 'users#index', :as => :user_root
  end

  resources :books
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "books#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
