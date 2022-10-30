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
  end

  scope module: :public do
    get "/Furusato_Ambassador" => "homes#top", as: "homes_top"
    get "homes/about"
    get "users/confirm" => "users#confirm"
    patch "users/unsubscribe" => "users#unsubscribe"
    resources :users, only: [:show, :edit, :update, :index]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
