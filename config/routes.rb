Rails.application.routes.draw do
  post 'slo/notify', as: :slo_notify
  get 'sso/auth', as: :sso_auth
  get 'main/welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
