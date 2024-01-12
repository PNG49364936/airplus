class GeocodingController < ApplicationController
    require 'httparty'
    def show
        
          pp "show1" * 100
          @coordinates = session[:coordinates]
          pp "show2" * 100
          Rails.logger.debug "@coordinates in show action2: #{@coordinates.inspect}"
          @place_name = params[:place_name]
          #session.delete(:coordinates)
          #session.delete(:place_name) # Nettoyer la session
         
    end

  def geocode
    pp "1" * 100
    Rails.logger.debug "Received place_name: #{params[:place_name]}"
    if params[:place_name].present?
      pp "2" * 100
      search_query = "#{params[:place_name]}, #{params[:country_name]}"
      pp "3" * 100
      session[:coordinates] = geocode_place(search_query, "pk.eyJ1IjoicG5nYXV0aGllciIsImEiOiJjbHFncjBjMG0xZGNlMm1ubWV2aXU1NnpmIn0.x06uuDfCgcRIZtJNmrF7Bg")
      session[:place_name] = params[:place_name] 
      Rails.logger.debug "@coordinates in show action1: #{@coordinates.inspect}"
      pp "4" * 100
      redirect_to action: :show
      else
        render :geocode
  
    end
  end

  private

  def geocode_place(place_name, access_token)
    pp "11" * 100
    base_url = "https://api.mapbox.com/geocoding/v5/mapbox.places"
    pp "12" * 100
    search_url = "#{base_url}/#{CGI.escape(place_name)}.json"
    pp "13" * 100
    response = HTTParty.get(search_url, query: { access_token: access_token })
    pp "14" * 100
    Rails.logger.debug "Full response from Mapbox API: #{response.parsed_response.inspect}"
    pp "15" * 100
    if response.success?
      data = JSON.parse(response.body) # Analyser explicitement la réponse JSON
      
      first_feature = data["features"].first if data["features"] && data["features"].any?
      
      if first_feature
        center_coordinates = first_feature["center"]
        Rails.logger.debug "Center-Coordinates1: #{center_coordinates}"
        return center_coordinates
      else
        Rails.logger.debug "No features found in response"
        return nil
      end
    else
      Rails.logger.debug "Error in API request"
      return nil
    end
  end

 



end
