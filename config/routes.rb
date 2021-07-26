Rails.application.routes.draw do
  root 'top#home'
  get  '/', to: 'top#home'
  resources :jobs
end
