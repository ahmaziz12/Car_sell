Rails.application.routes.draw do
  root to: 'ads#index'

  devise_for :users
  resources :ads
  resources :after_ad_post
  # get '/pay', to: 'after_ad_post#pay'

end
