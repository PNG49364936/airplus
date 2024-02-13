class PagesController < ApplicationController
  

  def home
    
 
      @stations = Station.all
  
      # Utiliser les coordonnées stockées dans chaque station pour créer le tableau des coordonnées
      @stations_coordinates = @stations.map do |station|
        [station.longitude, station.latitude] if station.longitude && station.latitude
      end.compact # Utilisez .compact pour éliminer les éléments nil du tableau
    end

end



 # def update_station_coordinates
  #  Station.find_each do |station|
     # coordinates = geocode_place("#{station.place_name}, #{station.country_name}", "votre_access_token_mapbox")
     # if coordinates
     #   station.update(latitude: coordinates[1], longitude: coordinates[0])
     # end
    #end
 # end


 

   # def geocode_place(place_name, access_token)
   #   base_url = "https://api.mapbox.com/geocoding/v5/mapbox.places"
   #   search_url = "#{base_url}/#{CGI.escape(place_name)}.json"
   #   response = HTTParty.get(search_url, query: { access_token: access_token })
  
    #  if response.success?
    #   data = JSON.parse(response.body)
      #  first_feature = data["features"].first if data["features"] && data["features"].any?
      #  first_feature ? first_feature["center"] : nil
     # else
     #   nil
     #end
    #end