Rails.application.routes.draw do

  root 'home#index'

  namespace :admin do 
    resources :dashboard, only: [:index]
    resources :libraries
    resources :login, only: [:create, :index]
    resources :logout, only: [:index]
  end

  resources :about, only: [:index]
  resources :archive, only: [:index]
  resources :contact_us, only: [:index]
  resources :events, only: [:index]
  resources :home, only: [:index]

  namespace :ranking do 
    resources :by_followers, only: [:index]
    resources :by_mentions, only: [:index]
    resources :by_tweets, only: [:index]
  end


end
