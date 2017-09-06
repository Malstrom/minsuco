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

  # view routes
  get '/widgets' => 'widgets#index'
  get '/documentation' => 'documentation#index'

  get 'dashboard/dashboard'
  get 'dashboard/dashboard_v1'
  get 'dashboard/dashboard_v2'
  get 'dashboard/dashboard_v3'
  get 'dashboard/dashboard_h'
  get 'elements/button'
  get 'elements/notification'
  get 'elements/spinner'
  get 'elements/animation'
  get 'elements/dropdown'
  get 'elements/nestable'
  get 'elements/sortable'
  get 'elements/panel'
  get 'elements/portlet'
  get 'elements/grid'
  get 'elements/gridmasonry'
  get 'elements/typography'
  get 'elements/fonticons'
  get 'elements/weathericons'
  get 'elements/colors'
  get 'elements/buttons'
  get 'elements/notifications'
  get 'elements/carousel'
  get 'elements/tour'
  get 'elements/sweetalert'
  get 'forms/standard'
  get 'forms/extended'
  get 'forms/validation'
  get 'forms/wizard'
  get 'forms/upload'
  get 'forms/xeditable'
  get 'forms/imgcrop'
  get 'multilevel/level1'
  get 'multilevel/level3'
  get 'charts/flot'
  get 'charts/radial'
  get 'charts/chartjs'
  get 'charts/chartist'
  get 'charts/morris'
  get 'charts/rickshaw'
  get 'tables/standard'
  get 'tables/extended'
  get 'tables/datatable'
  get 'tables/jqgrid'
  get 'maps/google'
  get 'maps/vector'
  get 'extras/mailbox'
  get 'extras/timeline'
  get 'extras/calendar'
  get 'extras/invoice'
  get 'extras/search'
  get 'extras/todo'
  get 'extras/profile'
  get 'extras/contacts'
  get 'extras/contact_details'
  get 'extras/projects'
  get 'extras/project_details'
  get 'extras/team_viewer'
  get 'extras/social_board'
  get 'extras/vote_links'
  get 'extras/bug_tracker'
  get 'extras/faq'
  get 'extras/help_center'
  get 'extras/followers'
  get 'extras/settings'
  get 'extras/plans'
  get 'extras/file_manager'
  get 'blog/blog'
  get 'blog/blog_post'
  get 'blog/blog_articles'
  get 'blog/blog_article_view'
  get 'ecommerce/ecommerce_orders'
  get 'ecommerce/ecommerce_order_view'
  get 'ecommerce/ecommerce_products'
  get 'ecommerce/ecommerce_product_view'
  get 'ecommerce/ecommerce_checkout'
  get 'forum/forum_categories'
  get 'forum/forum_topics'
  get 'forum/forum_discussion'
  get 'pages/login'
  get 'pages/register'
  get 'pages/recover'
  get 'pages/lock'
  get 'pages/template'
  get 'pages/notfound'
  get 'pages/maintenance'
  get 'pages/error500'

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
