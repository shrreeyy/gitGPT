Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'homes#index'

  scope :git do
    get '/repositories', to: 'git/repositories#index', as: 'repositories'
    get '/pull-requests', to: 'git/pull_requests#index', as: 'pull_requests'
  end
end
