class PagesController < ApplicationController
  def home
  end

  def home
    @stations = Station.all
      @stations_coordinates = @stations.map do |station|
        Rails.logger.debug "Stations Coordinates: #{@stations_coordinates.inspect}"
        geocode_place("#{station.place_name}, #{station.country_name}", "pk.eyJ1IjoicG5nYXV0aGllciIsImEiOiJjbHFncjBjMG0xZGNlMm1ubWV2aXU1NnpmIn0.x06uuDfCgcRIZtJNmrF7Bg")
     end
    end


    private

    def geocode_place(place_name, access_token)
      base_url = "https://api.mapbox.com/geocoding/v5/mapbox.places"
      search_url = "#{base_url}/#{CGI.escape(place_name)}.json"
      response = HTTParty.get(search_url, query: { access_token: access_token })
  
      if response.success?
        data = JSON.parse(response.body)
        first_feature = data["features"].first if data["features"] && data["features"].any?
        first_feature ? first_feature["center"] : nil
      else
        nil
      end
    end

end
