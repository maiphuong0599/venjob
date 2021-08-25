Rails.application.routes.draw do
  root 'top#index'
  get 'cities', to: 'cities#show'
  get 'industries', to: 'industries#show'
  get 'jobs/city/:city_slug', to: 'jobs#index', as: 'city_slug'
  get 'jobs/industry/:industry_slug', to: 'jobs#index', as: 'industry_slug'
  get 'detail/:job_slug', to: 'jobs#show', as: 'detail'
  get 'apply', to: 'apply_jobs#new'
  post 'confirm', to: 'apply_jobs#confirm'
  post 'done', to: 'apply_jobs#done'
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations',
                                    passwords: 'users/passwords', sessions: 'users/sessions' }, skip: [:sessions, :registrations, :passwords]
  resources :user
  get '/my', to: 'users#show'
  devise_scope :user do
    get 'register/1', to: 'users/registrations#new', as: :new_user_registration
    get 'register/2', to: 'users/registrations#show'
    get 'my/info', to: 'users/registrations#edit', as: :edit_user_registration
    match '/my', to: 'devise/registrations#create', as: :user_registration, via: [:post]
    match '/my', to: 'devise/registrations#update', via: [:put, :patch]
    get 'forgot_password', to: 'users/passwords#new', as: :new_user_password
    get 'reset_password', to: 'users/passwords#edit', as: :edit_user_password
    match 'reset_password', to: 'users/passwords#update', via: [:put, :patch]
    match 'reset_password', to: 'users/passwords#create', as: :user_password, via: [:post]
    get 'login', to: 'users/sessions#new', as: :new_user_session
    post 'login', to: 'users/sessions#create', as: :user_session
    delete 'logout', to: 'users/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
  end
end