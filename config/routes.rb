Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions',
                                    confirmations: 'users/confirmations',
                                    passwords: 'users/passwords' }

  root 'homes#index'

  scope :git do
    resources :repositories, only: [:index], controller: 'git/repositories'
    resources :pull_requests, only: [:index], controller: 'git/pull_requests'
    resources :pull_request_files, only: [:index], controller: 'git/pull_request_files'
    resources :issues, only: [:new, :create], controller: 'git/issues'
    resources :reviews, only: [:create], controller: 'git/reviews'
  end

  scope :openai do
    resources :audit_code, only: [:new], controller: 'openai/audit_code'
    resources :audit_context, only: [:new], controller: 'openai/audit_context'
  end
end
