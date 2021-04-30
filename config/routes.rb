Rails.application.routes.draw do
  get 'slo/front'
  post 'slo/back'
  get 'sso/auth', as: :sso_auth
  get 'main/welcome'
  root to: "main#welcome"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
