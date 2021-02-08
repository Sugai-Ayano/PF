Rails.application.routes.draw do
  get 'registrations/sign_up_params'
  devise_for :users
  root :to => "homes#top"
  get "/about" => "homes#about"
  post '/homes/guest_sign_in', to: 'homes#new_guest'
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  get 'search/search'
  get '/search', to: 'search#search'

  resources :users, only:[:index, :show, :edit, :update] do
    member do
      get 'confirm' => 'users#confirm'
      patch 'hide' => 'users#hide'
      put "/users/:id/hide" => "users#hide", as: 'users_hide'
    end
  end

  resource :relationships, only:[:create, :destroy] do
    member do
      get 'follows' => 'relationships#follows', as: 'follows'
    	 get 'followers' => 'relationships#followers', as: 'followers'
    end
  end

  resources :posts do
    resource :favorites, only:[:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :genres, only: [:index] do
    member do
      post 'season' => 'genres#season'
    end
  end

end

