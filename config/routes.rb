Rails.application.routes.draw do

  get '/history-back', to: 'application#history_back', as: 'history_back'

  get '/events/:id/readed', to: 'events#readed', as: 'readed'

  mount Payola::Engine => '/payola', as: :payola
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get "/invites/:provider/contact_callback" => "invites#index"
  # get "/contacts/failure" => "invites#failure"

  # get "/contacts/:importer/callback" => "onboarding#invite"

  match '/contacts/:importer/callback' => 'friends#import', :via => [:get]

  # Google
  match '/oauth2callback' => 'friends#import', :via => [:get]

  # localized do
    devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: 'users/omniauth_callbacks' }
  # end

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  get 'users/:id/intent', to: 'users#intent', as: 'user_intent'

  # iarena sign_in
  get  'iarena/authorize',  to: 'iarena#authorize',      as: 'iarena_authorize'
  get  'iarena/sign_in',    to: 'iarena#iarena_sign_in', as: 'iarena_sign_in'
  post 'iarena/sign_up',    to: 'iarena#iarena_sign_up', as: 'iarena_sign_up'

  # iarena invoice
  get  'iarena/pdf',   to: 'iarena#pdf',            as: 'iarena_pdf'
  post 'iarena/insert',to: 'iarena#insert_invoice', as: 'iarena_insert_invoice'

  resources :users do
    member do
      get :plans
      patch :theme
      patch :stop_tour
      patch :active_tour
    end
    get :races, to: 'races#user_races'
    get :events, to: 'events#index'
    resources :attendees
    resources :friends do
      collection do
        get :invite_from_google
        get :import
        post :invites
      end
    end
  end

  resources :races do
    # post :races
    collection do
      get :private_network
    end
    member do
      get :like
      get :start
      get :pause
      get :public_url
      get :publish, to: 'races#publish'
      get :publish_check, to: 'races#publish_check'
      patch :publish_check, to: 'races#publish_check'
    end
    resources :attendees
  end
  resources :subscriptions


  # Angle routes --- they be removed at the end of 1.0 project
  # defaults to dashboard
  # root :to => redirect('/on-boarding/invite')
  root to: redirect('dashboard/dashboard')

  get 'dashboard/dashboard'

  # the rest goes to root
  get '*path' => redirect('/')


  namespace :api do
    namespace :v1 do
      # another api routes
      get '/me' => "credentials#me"
    end
  end

  # mount ActionCable.server => '/cable'
end
