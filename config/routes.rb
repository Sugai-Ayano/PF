Rails.application.routes.draw do
  root :to => "homes#top"
  resources :user, only:[:show, :edit, :update] do
    member do
      get 'confirm' => 'users#confirm'
      patch 'hide' => 'users#hide'
    end
  end

  resource :relationships, only:[:create, :destroy] do
    member do
      get 'follows' => 'relationships#follows', as: 'follows'
    	 get 'followers' => 'relationships#followers', as: 'followers'
    end
  end

  resources :post, only:[:create, :destroy] do
    resource :favorites, only:[:create, :destroy]
  end

  resources :posts
end
