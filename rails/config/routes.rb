# Rails.application.routes.draw do
# mount_devise_token_auth_for 'User', at: 'auth'
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Defines the root path route ("/")
#   # root "articles#index"
# end

Rails.application.routes.draw do
  # letter_opener_web 用のルーティング
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :api do
    namespace :v1 do
      get "health_check", to: "health_check#index"
      mount_devise_token_auth_for "User", at: "auth"
    end
  end
end
