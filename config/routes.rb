Rails.application.routes.draw do

  root 'home#index'

  namespace :admin do 
    resources :dashboard, only: [:index]
    resources :libraries
    resources :login, only: [:create, :index]
    resources :logout, only: [:index]
  end

  resources :about, only: [:index]
  resources :archive, only: [:index, :show]
  resources :contact_us, only: [:index]
  resources :events, only: [:index]
  resources :home, only: [:index]
  resources :search, only: [:index]

  namespace :ranking do 
    resources :by_followers, only: [:index]
    resources :by_mentions, only: [:index]
    resources :by_tweets, only: [:index]
  end

  namespace :stats do 
    
    namespace :over_time do 
      resources :changes_in_followers
      resources :followers 
      resources :mentions
      resources :tweets 
    end

    namespace :ratios do 
      resources :hashtags 
      resources :links
      resources :mentions 
    end

    namespace :totals do 
      resources :changes_in_followers
      resources :mentions
      resources :tweets
    end

  end


end
