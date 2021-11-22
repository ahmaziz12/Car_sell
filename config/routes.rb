Rails.application.routes.draw do
  root to: 'ads#index'

  devise_for :users
  resources :ads do
    member do
      patch :close
      patch :open
      get :favourite
      get :unfavourite
    end
  end

  resources :after_ad_post
  resource :checkout, only: :show do
    collection do
      get :success
    end
  end

end
