Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'

  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'homes#index'

  scope :git do
    get '/repositories', to: 'git/repositories#index', as: 'repositories'
    get '/pull-requests', to: 'git/pull_requests#index', as: 'pull_requests'
    get '/pull-request-files', to: 'git/pull_request_files#index', as: 'pull_request_files'
  end

  scope :openai do
    post '/audit-code', to: 'openai/audit_code#create', as: 'audit_code'
  end
end
