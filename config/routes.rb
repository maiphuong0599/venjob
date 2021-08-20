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
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
  resources :users, :only => [:show]
  post '/my', to: 'users#show'
  devise_scope :user do
    get 'register/1', to: 'devise/confirmations#new'
    post 'register/2', to: 'devise/confirmations#create'
    get 'registration/3', to: 'devise/registrations#new'
  end
end