Rails.application.routes.draw do
  get 'projects', to: 'projects#index', as: 'projects'
  resources :projects do
    resources :tickets
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Temporary
  # resources :users

  root "projects#index"
end
