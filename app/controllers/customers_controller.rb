class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :destroy]
  
  def index
    @customers = Customer.all
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params_customer)
    if @customer.save
      redirect_to @customer, notice: 'Customer was successfully created.'
      else
           @customers = Customer.all
          render :new

     end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  def book
    @q = Flight.ransack(params[:q])
    @flights = if params[:q].present?
      @q.result.includes(:airline_code, :registration, :aircraft, :haul, :cabin, :seat, :departure_station, :arrival_station)
    else
      Flight.none # Ne renvoie aucun vol initialement
    end
    
    @aircrafts = Aircraft.all
    @airlineCodes = AirlineCode.all
    @Stations = Station.all
  end
  private

  def set_customer
    @customer = Customer.find(params[:id]) 
 end

  def params_customer
    params.require(:customer).permit(:name,:first_name) # Liste des attributs que vous utilisez
  end

end
