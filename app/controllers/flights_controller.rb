class FlightsController < ApplicationController
  require "registration"
 
  before_action :set_flight, only: [:show, :edit, :update, :destroy, :create_return]
  before_action :set_select_collections, only: [:new, :create, :edit, :update]

  def index
    @flights = Flight.all
    @aircrafts = Aircraft.all
    @q = Flight.ransack(params[:q])
    @flights = @q.result.includes(:airline_code)
  end

  def show
  end

  def new
    @flight = Flight.new
    
     
  end

  def create
    @flight = Flight.new(flight_params)
    if @flight.save
      redirect_to @flight, notice: 'Flight created.'
    else
      render :new
    end
  end

  def create_return
    original_flight = Flight.find(params[:id])
    # Logique pour créer le vol retour (à ajuster selon votre implémentation)
    new_flight = Flight.create_return_flight(original_flight) # Supposons que cette méthode gère correctement la création
    if new_flight.save
      redirect_to flights_path, notice: 'Vol retour créé avec succès.'
    else
      redirect_to flights_path, alert: 'Erreur lors de la création du vol retour.'
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

  def available_registrations
    pp "1" * 100
    departure_date = params[:departure_date]
    puts departure_date
    used_registrations = Flight.where(departure_date: departure_date).pluck(:registration_id)
    pp "2" * 100
   #puts used_registrations
    available_registrations = Registration.where.not(id: used_registrations)
    
    #puts available_registrations
    # Renvoyer les registrations disponibles au format JSON
        available_registrations.each do |registration|
          puts "ID: #{registration.id}, Reg: #{registration.reg}"
        end
    @available_registrations = available_registrations
    puts @available_registrations
    logger.debug "@available_registrations: #{@available_registrations.inspect}"
    #render json: available_registrations
    render json: @available_registrations.map{|r| {id: r.id, reg: r.reg}}
  end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end

  def flight_params
    params.require(:flight).permit(:registration_id, :aircraft_id, :cabin_id, :haul_id, :seat_id, :departure_station_id, :arrival_station_id, :flight_number, :airline_code_id, :airport_name, :departure_date, :arrival_date, :date_range)
  end

  def set_select_collections
    @registrations = Registration.all
    @aircraft = Aircraft.all
    @haul = Haul.all
    @cabin = Cabin.all
    @seat = Seat.all
    @departure_stations = Station.all
    @arrival_stations = Station.all
    @stations = Station.all
    @airline_codes = AirlineCode.all

    #used_registrations = Flight.pluck(:registration_id)
    #used_registration_numbers = Registration.where(id: used_registrations).pluck(:reg)
    #@available_registrations = Registration.where.not(reg: used_registration_numbers)
  end

  # dans app/controllers/flights_controller.rb

# Nouvelle action pour obtenir les registrations disponibles


end
