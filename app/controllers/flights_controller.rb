class FlightsController < ApplicationController
  require "registration"
 
  before_action :set_flight, only: [:show, :edit, :update, :destroy, :create_return]
  before_action :set_select_collections, only: [:new, :create, :edit, :update]
  before_action :set_available_registrations
  before_action :set_available_aircrafts

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

    @flights = Flight.all
    Rails.logger.debug "Available RegistrationsSSSS: #{@available_registrations.inspect}"
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
    haul_id = params[:haul_id].to_i
    pp "a"*100
    puts haul_id
    logger.debug "Haul ID__________: #{haul_id}"
    pp "1" * 100
    departure_date = params[:departure_date]
    logger.debug "Departure date__________: #{departure_date}"
    puts departure_date
    used_registrations = Flight.where(departure_date: departure_date).pluck(:registration_id)
    pp "2" * 100
   puts used_registrations.inspect
   available_registrations = Registration.where.not(id: used_registrations).where(haul_id: haul_id)
    #puts available_registrations
    # Renvoyer les registrations disponibles au format JSON
        available_registrations.each do |registration|
          puts "Available -- ID: #{registration.id}, Reg: #{registration.reg}, Haul: #{registration.haul} "
        end
    @available_registrations = available_registrations
    puts " xxx @available_registrations"
    logger.debug "@available_registrations: #{@available_registrations.inspect}"
    #render json: available_registrations
    
    render json: @available_registrations.map{|r| {id: r.id, reg: r.reg, haul: r.haul}}
  end

  #def available_registrations_by_haul
   # haul_id = params[:haul_id]
   # available_registrations = Registration.where(haul_id: haul_id)
  
   # render json: available_registrations.map{|r| {id: r.id, reg: r.reg}}
  #end

  def available_aircrafts
    puts "controller available_aircrafts"*100
    haul_id = params[:haul_id].to_i
    puts "haul_id available_aircrafts"*10
    puts haul_id.inspect
  
    if haul_id == Haul.find_by(name: 'MH').id
      available_aircrafts = Aircraft.where(haul_id: haul_id)
    else
      available_aircrafts = Aircraft.where(haul_id: [Haul.find_by(name: 'LH').id, Haul.find_by(name: 'MH').id])
    end
  
    @available_aircrafts = available_aircrafts
    logger.debug "@available_aircraftssssss: #{@available_aircrafts.inspect}"
    render json: @available_aircrafts.map{|r| {id: r.id, acft: r.acft}}
  end



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

  def set_available_aircrafts
    puts "private available_aircraft" * 10
    @available_aircrafts = Aircraft.all
    Rails.logger.debug "@available_aircrafts set with #{@available_aircrafts.count} items"
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