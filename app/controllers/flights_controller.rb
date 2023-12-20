class FlightsController < ApplicationController
  require "registration"
 
  before_action :set_flight, only: [:show, :edit, :update, :destroy]
 
  def index
    @flights = Flight.all
    @aircrafts = Aircraft.all
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
    
    @used_registrations = Flight.pluck(:registration_id)
    @used_registration_numbers = Registration.where(id: @used_registrations).pluck(:reg)
    @available_registrations = Registration.where.not(reg: @used_registration_numbers)
    puts "@available_registrations: #{@available_registrations.inspect}"
    @registration =  Registration.all
    @aircraft = Aircraft.all
    @haul = Haul.all
    @cabin = Cabin.all
    @seat = Seat.all
    @departure_stations = Station.all
    @arrival_stations = Station.all
    @airline_codes = AirlineCode.all
    
   

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

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end

  def params_flight
    params.require(:flight).permit(:registration_id, :aircraft_id, :cabin_id, :haul_id, :seat_id, :departure_station_id, :arrival_station_id, :flight_number, :airline_code_id)
  end



end
