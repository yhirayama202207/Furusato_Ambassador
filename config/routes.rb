Rails.application.routes.draw do

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    get "/" => "homes#top"
  end

  scope module: :public do
    get "/Furusato_Ambassador" => "homes#top", as: "homes_top"
    get "homes/about"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
