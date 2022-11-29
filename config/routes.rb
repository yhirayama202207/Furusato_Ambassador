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
    get "users/mypage" => "users#mypage"
    get "users/user_articles" => "users#user_articles", as: "user_articles"
    patch "users/unsubscribe" => "users#unsubscribe"
    get "articles/prefectures/:id" => "articles#prefecture_index", as: "articles_prefecture_index"
    get "articles/areas/:id" => "articles#area_index", as: "articles_area_index"
    resources :users, only: [:show, :edit, :update, :index] do
      resource :relationships, only: [:create, :destroy]
      #memberとすることでidを取得できる
      get :followings, on: :member
      get :followers, on: :member
      get :likes, on: :member
      get :foot_prints, on: :member
      get :clips, on: :member
      collection do
        get "search"
      end
    end
    resources :articles, only: [:new, :create, :show, :edit, :update, :index, :destroy] do
      resources :comments, only: [:create, :edit, :update, :index, :destroy]
      resource :likes, only: [:create, :destroy]
      resource :foot_prints, only: [:create, :destroy]
      resource :clips, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
