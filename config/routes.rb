Rails.application.routes.draw do
  devise_for :users
  root :to => "homes#top"
  get "/about" => "homes#about"
  resources :user, only:[:show, :edit, :update] do
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
    resources :favorites, only:[:create, :destroy]
  end

  resources :genres, only: [:index]
end

