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
end