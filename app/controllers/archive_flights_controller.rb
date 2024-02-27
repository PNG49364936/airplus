class FlightsController < ApplicationController
    require "registration"
   
    before_action :set_flight, only: [:show, :edit, :update, :destroy, :create_return]
   
    def index
      @flights = Flight.all
      @aircrafts = Aircraft.all
      @q = Flight.ransack(params[:q])
      @flights = @q.result.includes(:airline_code)
     
    end
  
    def show
    end
  
    def new
      @flight =Flight.new
      @registration =  Registration.all
      @registration = Registration.first
      @aircraft = Aircraft.all
      @aircraft = Aircraft.first
      @haul = Haul.all
     
      @cabin = Cabin.all
      @cabin = Cabin.first
      @seat = Seat.all
      @seat = Seat.first
      @departure_stations = Station.all
      @arrival_stations = Station.all
      @stations = Station.all
      @airline_codes = AirlineCode.all    
     
     
  
  
     
      @used_registrations = Flight.pluck(:registration_id)
      @used_registration_numbers = Registration.where(id: @used_registrations).pluck(:reg)
      @available_registrations = Registration.where.not(reg: @used_registration_numbers)
  
     
  
      
    end
  
    def create
      puts "Parameters: #{params.inspect}"
      @flight = Flight.new(params_flight)
         if @flight.save
      redirect_to @flight, notice: 'Flight created.'
    else
      #definir @used_registrations
      @used_registrations = Flight.pluck(:registration_id)
      @used_registration_numbers = Registration.where(id: @used_registrations).pluck(:reg)
      @available_registrations = Registration.where.not(reg: @used_registration_numbers)
      puts "@available_registrations********: #{@available_registrations.inspect}"
      @registration =  Registration.all
      #@others
      @aircraft = Aircraft.all
      @haul = Haul.all
      @cabin = Cabin.all
      @seat = Seat.all
      @departure_stations = Station.all
      @arrival_stations = Station.all
      @airline_codes = AirlineCode.all
  
      def create_return
        original_flight = Flight.find(params[:id])
        # Logique pour créer le vol retour (voir l'exemple de méthode dans le modèle Flight)
        new_flight_number = flight.flight_number.to_i.even? ? flight.flight_number.to_i + 1 : flight.flight_number.to_i + 1
        Flight.create(
          airline_code_id: flight.airline_code_id,
          flight_number: new_flight_number.to_s,
          registration_id: flight.registration_id,
          aircraft_id: flight.aircraft_id,
          cabin_id: flight.cabin_id,
          seat_id: flight.seat_id,
          departure_station_id: flight.arrival_station_id,
          arrival_station_id: flight.departure_station_id,
          departure_date: flight.arrival_date + 1.day, # Exemple d'ajustement de la date
          arrival_date: flight.departure_date + 1.day + 2.hours # Exemple d'ajustement de la date
          # Ajoutez d'autres champs nécessaires ici
        )
        new_flight = Flight.create_return_flight(original_flight)
        
        if new_flight.save
          redirect_to flights_path, notice: 'Vol retour créé avec succès.'
        else
          redirect_to flights_path, alert: 'Erreur lors de la création du vol retour.'
        end
      end
      
     
  
      render :new
    end
    end
  
    def edit
    end
  
    def destroy
      @flight.destroy
      redirect_to flights_url, notice: 'Flights Ops was successfully destroyed.'
    end
  
    def update
    end
  
    def stations
      flight_haul_id = params[:flight_haul]
    haul = Haul.find_by(id: flight_haul_id)
  
    if haul
      @stations = Station.where(haul: haul.name)
    else
      @stations = Station.none
    end
  
    render json: { stations: @stations.select(:id, :name).map(&:attributes) }
    end
  
    def create_return
      original_flight = Flight.find(params[:id])
      new_flight = Flight.create_return_flight(original_flight)
      new_flight.is_return_flight = true
      if new_flight.save
        pp "1" * 100
        redirect_to flights_path, notice: 'Vol retour créé avec succès.'
      else
        pp "2" * 100
        redirect_to flights_path, alert: 'Erreur lors de la création du vol retour.'
      end
    end
  
    
  
    private
  
    def set_flight
      @flight = Flight.find(params[:id])
    end
  
    def params_flight
      params.require(:flight).permit(:registration_id, :aircraft_id, :cabin_id, :haul_id, :seat_id, :departure_station_id, :arrival_station_id, :flight_number, :airline_code_id, :airport_name, :departure_date, :arrival_date, :date_range)
    end
  
  
  
  end