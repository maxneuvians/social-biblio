Rails.application.routes.draw do

  root 'home#index'

  namespace :admin do 
    resources 'dashboard'
    resources 'libraries'
    resources 'login'
    resources 'logout'
  end

end
