Rails.application.routes.draw do
  resources :documentation
  resources :repositories
  devise_for :users
  resources :users
  resources :review_issues
  resources :reviews do
    member do
      get 'complete'
    end
  end
  root 'dashboard#index'
end
