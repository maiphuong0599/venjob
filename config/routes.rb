Rails.application.routes.draw do
  root 'top#home'
  get  'cities', to: 'cities#show'
  get  'industries', to: 'industries#show'
  get  'jobs/city/:city_slug', to: 'jobs#show', as: 'city_slug'
  get  'jobs/industry/:industry_slug', to: 'jobs#show', as: 'industry_slug'
end