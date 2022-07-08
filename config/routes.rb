Rails.application.routes.draw do
  resources :projects do
    resources :tickets

    # route to change ticket status from outside
    post 'ticket/:id/change_status/:status', to: 'tickets#change_status', as:'ticket_change_status'

    # routes to render form and send invitation
    post 'invite', to: 'projects#invite', as:'invite'
    post 'invite_form', to: 'projects#invite_form', as:'invite_form' # old way of sharing projects, replace path in the button with the new one


    # mail
    post 'share_project', to: 'projects#share_project', as:'share_project'

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
