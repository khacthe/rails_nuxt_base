Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  get "/docs", to: redirect("/api/dist/index.html")

  namespace :api, format: "json" do
    namespace :v1 do
      get "api-docs", to:"api_docs#index" unless Rails.env.production?
      resources :users
      scope "user" do
        post "sign_in", to: "sessions#sign_in"
        post "sign_up", to: "sessions#sign_up"
        get "sign_out", to: "sessions#sign_out"
        get "verify_user", to: "sessions#verify_user"
        post "forgot_password", to: "sessions#forgot_password"
        post "password_reset", to: "sessions#password_reset"
      end
    end
  end
end
