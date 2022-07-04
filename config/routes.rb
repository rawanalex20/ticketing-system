Rails.application.routes.draw do
  get 'shared_projects', to: 'projects#shared', as: 'shared_projects'
  resources :projects do
    resources :tickets
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Temporary
  # resources :users

  root "home#index"
end
