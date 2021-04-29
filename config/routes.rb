Rails.application.routes.draw do
  get 'slo/front', as: :slo_front
  post 'slo/back', as: :slo_back
  get 'sso/auth', as: :sso_auth
  get 'main/welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
