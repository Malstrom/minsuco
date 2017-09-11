Rails.application.routes.draw do

  get '/history-back', to: 'application#history_back', as: 'history_back'

  get '/events/:id/readed', to: 'events#readed', as: 'readed'

  get 'users/:id/intent', to: 'users#intent', as: 'user_intent'

  mount Payola::Engine => '/payola', as: :payola
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  # get "/invites/:provider/contact_callback" => "invites#index"
  # get "/contacts/failure" => "invites#failure"

  # get "/contacts/:importer/callback" => "onboarding#invite"

  match '/contacts/:importer/callback' => 'friends#import', :via => [:get]

  # Google
  match '/oauth2callback' => 'friends#import', :via => [:get]

  resources :subscriptions


  resources :users do
    member do
      get :plans
      patch :theme
    end
    get :races, to: 'races#user_races'
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
    member do
      get :like
      get :start
      get :pause
      get :publish, to: 'races#publish'
      get :publish_check, to: 'races#publish_check'
      patch :publish_check, to: 'races#publish_check'
    end
    resources :attendees
  end

  # Angle routes --- they be removed at the end of 1.0 project
  # defaults to dashboard
  # root :to => redirect('/on-boarding/invite')
  root to: redirect('dashboard/dashboard')

  get 'dashboard/dashboard'

  # api routes
  get '/api/documentation' => 'api#documentation'
  get '/api/datatable' => 'api#datatable'
  get '/api/jqgrid' => 'api#jqgrid'
  get '/api/jqgridtree' => 'api#jqgridtree'
  get '/api/i18n/:locale' => 'api#i18n'
  post '/api/xeditable' => 'api#xeditable'
  get '/api/xeditable-groups' => 'api#xeditablegroups'

  # the rest goes to root
  get '*path' => redirect('/')

  # mount ActionCable.server => '/cable'
end
