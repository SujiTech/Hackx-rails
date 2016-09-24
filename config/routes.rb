Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'welcome#index'

  resources :users, only: [:index]
  resources :attendees
  resources :projects
  resources :events, except: [:new]
  resources :organizations do
    resources :events, only: [:new]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
