Rails.application.routes.draw do

  devise_for :users
  root 'landing#index'

  devise_for :workers, :controllers => {:registrations => "registrations"}

  resources :jobs
  resources :workers, only: [:index, :show]
end
