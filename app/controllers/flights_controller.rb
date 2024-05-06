class FlightsController < ApplicationController
  require "registration"
 
  before_action :set_flight, only: [:show, :edit, :update, :destroy, :create_return]
  before_action :set_select_collections, only: [:new, :create, :edit, :update]
  before_action :set_available_registrations

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
    @hauls = Haul.all
    @available_registrations = Registration.all
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
    
    # Assurez-vous que la méthode create_return_flight définit is_return_flight à true
    new_flight = Flight.create_return_flight(original_flight)
  
    if new_flight.persisted?
      # Si le vol retour a été persisté avec succès dans la base de données
      redirect_to flights_path, notice: 'Vol retour créé avec succès.'
    else
      # Incluez les erreurs spécifiques pour aider au débogage ou à l'information de l'utilisateur
      flash[:alert] = "Erreur lors de la création du vol retour: #{new_flight.errors.full_messages.join(', ')}"
      redirect_to flights_path
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
    haul = params[:haul]
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

  #def available_registrations_by_haul
   # haul_id = params[:haul_id]
   # available_registrations = Registration.where(haul_id: haul_id)
  
   # render json: available_registrations.map{|r| {id: r.id, reg: r.reg}}
  #end



  private

  def set_flight
    @flight = Flight.find(params[:id])
  end

  def flight_params
    params.require(:flight).permit(:registration_id, :aircraft_id, :cabin_id, :haul_id, :seat_id, :departure_station_id, :arrival_station_id, :flight_number, :airline_code_id, :airport_name, :departure_date, :arrival_date, :date_range)
  end

  def set_available_registrations
    pp "*"*20
    @available_registrations = Registration.all # Exemple simple de définition
    Rails.logger.debug "@available_registrations set with #{@available_registrations.count} items"
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
