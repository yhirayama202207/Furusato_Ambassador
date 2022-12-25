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

  devise_scope :user do
    post 'sessions/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
    get "/" => "homes#top"
    get "/admin/users/:id/user_articles" => "users#user_articles", as: "user_articles"
    get "articles/prefectures/:id" => "articles#prefecture_index", as: "articles_prefecture_index"
    get "articles/areas/:id" => "articles#area_index", as: "articles_area_index"
    get "/articles/tags/:id" => "articles#tag_index", as: "articles_tag_index"
    delete "comments/:id" => "comments#destroy", as: "comment_destroy"
    resources :japan_areas, only: [:index, :create, :edit, :update, :destroy]
    resources :japan_prefectures, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:show, :edit, :update, :index] do
      collection do
        get "search"
      end
    end
    resources :articles, only: [:index, :show, :update, :destroy] do
      collection do
        get "search"
      end
    end
    resources :comments, only: [:index, :destroy]
  end

  scope module: :public do
    get "/" => "homes#top", as: "homes_top"
    get "homes/about"
    get "users/confirm" => "users#confirm"
    get "users/mypage" => "users#mypage"
    get "users/:id/user_articles" => "users#user_articles", as: "user_articles"
    patch "users/unsubscribe" => "users#unsubscribe"
    get "articles/prefectures/:id" => "articles#prefecture_index", as: "articles_prefecture_index"
    get "articles/areas/:id" => "articles#area_index", as: "articles_area_index"
    get "articles/tags/:id" => "articles#tag_index", as: "articles_tag_index"
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
      resource :likes, only: [:create, :destroy] do
        post "create_show"
        delete "destroy_show"
      end
      resource :foot_prints, only: [:create, :destroy] do
        post "create_show"
        delete "destroy_show"
      end
      resource :clips, only: [:create, :destroy]
      collection do
        get 'search'
      end
    end
    resources :notifications, only: [:index]
    delete :notifications, to: 'notifications#destroy_all', as: "destroy_all_notifications"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
