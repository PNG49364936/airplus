Rails.application.routes.draw do
  get 'flights/stations', to: 'flights#stations'



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
  root to: 'pages#home'

  resources :aircrafts
  resources :cabins
  resources :seats
  resources :registrations
  resources :flights
  resources :hauls
  resources :stations
  resources :flight_numbers

  
  
end
