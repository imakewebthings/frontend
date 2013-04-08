DplaPortal::Application.routes.draw do
  devise_for :users, controllers: {
    :registrations => "registrations",
    :confirmations => "confirmations",
    :sessions      => "sessions",
    :passwords     => "passwords"
  }

  scope 'about', as: :about, via: :get do
    match 'overview',       to: 'pages#overview'
    match 'leadership',     to: 'pages#leadership'
    match 'workstreams',    to: 'pages#workstreams'
    match 'for-developers', to: 'pages#for_developers', as: 'for_developers'
    match 'get-involved',   to: 'pages#get_involved',   as: 'get_involved'
    root to: redirect('/about/overview')
  end

  get '/item/:id', to: 'items#show', as: 'item'

  resources :subjects, only: :index

  scope only: :show do
    resource :search,   controller: :search
    resource :timeline, controller: :timeline
    resource :map,      controller: :map
  end

  scope '/saved' do
    resources :saved_searches, path: 'searches', only: [:index, :create, :destroy] do
      post 'destroy_bulk', on: :collection
    end
    resources :saved_lists, path: 'lists', id: /\d+/ do
      get 'unlisted', action: :show, on: :collection
    end
    scope '/lists' do
      post   'add_item',              to: 'saved_lists#add_item',          as: :add_saved_item
      delete 'delete_item',           to: 'saved_lists#delete_item',       as: :delete_saved_item
      delete 'delete_positions',      to: 'saved_lists#delete_positions',  as: :delete_positions
      post   'reorder_positions',     to: 'saved_lists#reorder_positions', as: :reorder_positions
      post   'copy_positions',        to: 'saved_lists#copy_positions',    as: :copy_positions
      post   'move_positions',        to: 'saved_lists#move_positions',    as: :move_positions
    end
  end

  scope 'app-library', as: :app_library do
    match 'details', to: 'app_library#show'
    root to: 'app_library#index'
  end

  match '/welcome' => 'users#welcome'
  root to: 'pages#home'
end
