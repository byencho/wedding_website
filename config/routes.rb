WeddingWebsite::Application.routes.draw do

  resource :accommodations, controller: :accommodations, only: [:show]
  resource :coming_soon, controller: :coming_soon, only: [:show]
  resource :directions, controller: :directions, only: [:show]
  resource :faq, controller: :faq, only: [:show]
  resource :guest_book, controller: :guest_book, only: [:show]  
  resource :home, controller: :home, only: [:show]
  resource :recommendations, controller: :recommendations, only: [:show]
  resource :registry, controller: :registry, only: [:show]  
  resource :rsvp, controller: :rsvp, only: [:show]
  resource :schedule, controller: :schedule, only: [:show]
  resource :contact_us, controller: :contact_us, only: [:show]

  root to: 'home#show'

  # Accounts
  devise_for :accounts, :sign_out_via => [:get, :delete]
  namespace :accounts do
    root to: 'rsvp#show'
    resource :rsvp, controller: :rsvp, only: [:show]    
    resources :guests, only: [:create, :update, :destroy]
    resource :trouble, controller: :trouble, only: [:show]
  end

  # Admins
  devise_for :admin, :sign_out_via => [:get, :delete]
  namespace :admin do
    root to: 'guests#index'
    resources :guests, only: [:index]
    resources :accounts, only: [:index]
  end

end
