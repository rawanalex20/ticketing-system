Rails.application.routes.draw do
  resources :projects
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Temporary
  resources :users

  # TODO: root will be homepage containing project link
  # Leave this temporary
  root "users#index"
end
