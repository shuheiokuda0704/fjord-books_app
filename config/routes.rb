Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show) do
    resources :followings, only: %i(index), module: :users
    resources :followers, only: %i(index), module: :users
  end
  resources :followings, only: %i(create destroy)
end
