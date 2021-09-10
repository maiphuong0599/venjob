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
  get 'job_favorite', to: 'favorite_jobs#update', as: 'favorite_update'
  get 'favorite', to: 'favorite_jobs#index', as: 'favorite'
  delete 'unfavorite', to: 'favorite_jobs#destroy'
  get 'history', to: 'history_jobs#index', as: 'history'
  get '/my/jobs', to: 'apply_jobs#index', as: 'applied_job'
  devise_for :users, skip: %i[sessions registrations passwords], controllers: { confirmations: 'users/confirmations' }
  get '/my', to: 'users#show'
  devise_scope :user do
    get 'register/1', to: 'users/registrations#new', as: :new_user_registration
    get 'register/2', to: 'users/registrations#show'
    get 'my/info', to: 'users/registrations#edit', as: :edit_user_registration
    match '/my', to: 'users/registrations#create', as: :user_registration, via: [:post]
    match '/my', to: 'users/registrations#update', via: %i[put patch]
    get 'forgot_password', to: 'users/passwords#new', as: :new_user_password
    get 'reset_password', to: 'users/passwords#edit', as: :edit_user_password
    match 'reset_password', to: 'users/passwords#update', via: %i[put patch]
    post 'reset_password', to: 'users/passwords#create', as: :user_password
    get 'login', to: 'users/sessions#new', as: :new_user_session
    post 'login', to: 'users/sessions#create', as: :user_session
    delete 'logout', to: 'users/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
  end
end