Rails.application.routes.draw do
  resources :projects do
    resources :tickets

    # routes to render form and send invitation
    post 'invite', to: 'projects#invite', as:'invite'
    post 'invite_form', to: 'projects#invite_form', as:'invite_form'

    # attachments
    get '/tickets/:id/attach', to: 'tickets#attach', as: 'attach'
    patch '/tickets/:id/save_attach', to: 'tickets#save_attach', as: 'save_attach'

    # ticket due date
    post '/tickets/:id/due', to: 'tickets#due_date', as: 'due_form'
    get '/tickets/:id/due', to: 'tickets#due', as: 'ticket_due'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root "projects#index"
end
