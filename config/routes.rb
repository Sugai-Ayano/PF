Rails.application.routes.draw do
  get 'searches/search'
  get 'registrations/sign_up_params'
  devise_for :users
  root :to => "homes#top"
  get "/about" => "homes#about"

  # ゲストログイン機能
  get '/homes/guest_sign_in', to: 'homes#new_guest'
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  get 'search/search'
  get '/search', to: 'searches#search'

  resources :users, only:[:index, :show, :edit, :update] do
    member do
      get 'confirm' => 'users#confirm'
      patch 'hide' => 'users#hide'
      put "/users/:id/hide" => "users#hide", as: 'users_hide'
    end
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
  end

  resources :posts do
    resource :favorites, only:[:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

end

