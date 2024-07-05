class PagesController < ApplicationController
  
  before_action :set_map_data, only: [:home, :bigmap, :airplus]
  
  
  
  
  def bigmap
  end 

  def home
  end

  def airplus
  end


  private


  def set_map_data
    @stations = Station.all
    @flights = Flight.includes(:departure_station, :arrival_station)
  
    # Préparer les données des stations pour les markers sur la carte
    @stations_coordinates = @stations.map do |station|
      [station.longitude, station.latitude] if station.longitude && station.latitude
    end.compact
  
    # Préparer les données des chemins de vol pour tracer des lignes sur la carte
    @flight_paths = @flights.map do |flight|
     
      if flight.departure_station && flight.arrival_station
        pp flight.departure_station
        pp flight.arrival_station
        
      
        {
          id: flight.id, # Ajouter l'ID du vol pour créer un identifiant unique de la couche
          coordinates: [
            [flight.departure_station.longitude, flight.departure_station.latitude],
            [flight.arrival_station.longitude, flight.arrival_station.latitude]
          ]
          
        }
      end
    end.compact
  end




end




 