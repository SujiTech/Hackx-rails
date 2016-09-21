Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'welcome#index'

  # TODO: Only for prototype
  get 'prototype/homepage', to: 'welcome#index'
  get 'prototype/profile', to: 'welcome#profile'
  get 'prototype/project', to: 'welcome#project'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
