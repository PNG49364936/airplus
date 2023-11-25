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
    @haul = Haul.first
    @cabin = Cabin.all
    @cabin = Cabin.first
    @seat = Seat.all
    @seat = Seat.first
    @departure_station = Station.all
    @arrival_station = Station.all
   
    @used_registrations = Flight.pluck(:registration_id)
    @used_registration_numbers = Registration.where(id: @used_registrations).pluck(:reg)
    @available_registrations = Registration.where.not(reg: @used_registration_numbers)
   
   
  end

  def create
    @flight = Flight.new(params_flight)
       if @flight.save
    redirect_to @flight, notice: 'Flight created.'
  else
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

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end

  def params_flight
    params.require(:flight).permit(:registration_id, :aircraft_id, :cabin_id, :haul_id, :seat_id, :station_id, :departure_station_id, :arrival_station_id)
  end



end
