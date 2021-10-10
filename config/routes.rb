Rails.application.routes.draw do
  resources :routines do
    resources :exercises
  end
  post 'login', to: 'access_tokens#create'
  delete 'logout', to: 'access_tokens#destroy'
  post 'sign_up', to: 'registrations#create'
  get '/progress', to: 'exercises#progress'
end
