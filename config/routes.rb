Rails.application.routes.draw do

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    get "/" => "homes#top"
    resources :japan_areas, only: [:index, :create, :edit, :update]
    resources :japan_prefectures, only: [:index, :create, :edit, :update]
    resources :users, only: [:show, :edit, :update, :index]
    resources :articles, only: [:index, :show, :update, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  scope module: :public do
    get "/" => "homes#top", as: "homes_top"
    get "homes/about"
    get "users/confirm" => "users#confirm"
    patch "users/unsubscribe" => "users#unsubscribe"
    get "articles/prefectures/:id" => "articles#prefecture_index", as: "articles_prefecture_index"
    get "articles/areas/:id" => "articles#area_index", as: "articles_area_index"
    resources :users, only: [:show, :edit, :update, :index]
      resources :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
    resources :articles, only: [:new, :create, :show, :edit, :update, :index, :destroy] do
      resources :comments, only: [:create, :edit, :update, :index, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
