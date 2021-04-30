Rails.application.routes.draw do
  resources :routines
  post 'login', to: 'access_tokens#create'
  delete 'logout', to: 'access_tokens#destroy'
  post 'sign_up', to: 'registrations#create'
  resources :books
end
