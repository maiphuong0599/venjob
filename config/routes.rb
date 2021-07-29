Rails.application.routes.draw do
  root 'top#home'
  get  'cities', to: 'city#list_city'
  get  'industries', to: 'industry#list_industry'
end