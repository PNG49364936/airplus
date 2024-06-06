Rails.application.routes.draw do
  get 'pages/bigmap', to: 'pages#bigmap'
  get 'pages/home', to: 'pages#home'
  get 'pages/operations', to: 'pages#operations'
  get 'pages/about', to: 'pages#about'
  get 'flights/stations', to: 'flights#stations'
  get 'geocoding/show', to: 'geocoding#show'
  get 'geocoding/geocode', to: 'geocoding#geocode'
  get 'flights/index'
  get 'flights/show'
  get 'flights/new'
  get 'flights/create'
  get 'flights/edit'
  get 'flights/destroy'
  get 'flights/update'
  get 'registrations/index'
  get 'registrations/show'
  get 'registrations/new'
  get 'registrations/create'
  get 'registrations/edit'
  get 'registrations/update'
  get 'registrations/destroy'
  get 'pages/operations'
  get 'flights/available_registrations', to: 'flights#available_registrations'
  root to: 'pages#home'
 

  resources :aircrafts
  resources :cabins
  resources :seats
  resources :registrations
  resources :flights
  resources :hauls
  resources :stations
  resources :airline_codes

  resources :flights do
    member do
      post 'create_return'
    end
  end

  resources :flights do
    collection do
      get :available_aircrafts
    end
  end

  

  
  
end
