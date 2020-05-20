Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'registrations'
    }

  resources :projects do 
    resources :tasks
  end

  resources :tasks, only: [:destroy]

  get "tasks/mine", "tasks#mine"

  root 'projects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
