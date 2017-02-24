Rails.application.routes.draw do

  devise_for :users
  root 'landing#index'

  devise_for :workers, :controllers => {:registrations => "registrations"}

  resources :jobs do
    patch :mark_complete
    patch :currently_working
  end

  resources :workers, only: [:index, :show]

end
