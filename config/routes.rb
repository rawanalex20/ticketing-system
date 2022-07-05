Rails.application.routes.draw do
  get 'projects', to: 'projects#index', as: 'projects'
  resources :projects do
    resources :tickets
    post 'invite', to: 'projects#invite', as:'invite'
    post 'invite_form', to: 'projects#invite_form', as:'invite_form'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Temporary
  # resources :users

  root "projects#index"
end
