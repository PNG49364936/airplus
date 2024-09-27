class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :destroy]
  
  def index
    @customers = Customer.all

  end

  def show
  end

  def new
    @customer = Customer.new
    if params[:flight_id].present?
      @flight = Flight.find(params[:flight_id])
    else
      redirect_to customers_book_path, notice: 'Please select a flight first.'
    end
  end

  def create
    @customer = Customer.new(params_customer)
    @flight = Flight.find(params[:flight_id])

    if @customer.save
      booking = Booking.create(customer: @customer, flight: @flight)
      redirect_to @customer, notice: 'Customer was successfully booked on the flight.'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  #def destroy
   # customer = Customer.find(params[:id])
    #customer.bookings.discard_all
    #customer.bookings.update_all(status: 'cancelled')
    #customer.bookings.destroy_all
    #customer.destroy
    #redirect_to customers_url, notice: "Customer successfully destroyed."
    #def destroy
      #ActiveRecord::Base.transaction do
       # customer = Customer.find(params[:id])
       # customer.bookings.update_all(status: 'cancelled')
       # customer.destroy  # Use the standard destroy method
     # end
     # redirect_to customers_url, notice: "Customer successfully destroyed."
    #rescue ActiveRecord::RecordNotFound
      #redirect_to customers_url, alert: "Customer not found."
    #rescue => e
      #redirect_to customers_url, alert: "An error occurred: #{e.message}"
    #end
    def destroy
      ActiveRecord::Base.transaction do
        customer = Customer.find(params[:id])
        customer.bookings.update_all(status: 'cancelled')
        customer.soft_delete
        customer.destroy
      end
      redirect_to customers_url, notice: "Customer successfully marked as deleted."
    rescue ActiveRecord::RecordNotFound
      redirect_to customers_url, alert: "Customer not found."
    rescue => e
      redirect_to customers_url, alert: "An error occurred: #{e.message}"
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

  def reset_search
    @flights = Flight.none
    render json: { status: 'success' }
  end

  def list 
   
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

  def flight_customers
    #@flight = Flight.find(params[:flight_id])
    #pp "8"*100
    #logger.debug "@flighttttttttttttt: #{@flight.inspect}"
    #@customers = @flight.customers
    #pp "9"*100
    #logger.debug "@customersttttttttttttt: #{@customers.inspect}"
    @flight = Flight.find(params[:flight_id])
    @customers = @flight.customers.includes(:bookings)
                        .where(bookings: { status: 'active' })
  end
  private

  def set_customer
    @customer = Customer.find(params[:id]) 
 end

  def params_customer
    params.require(:customer).permit(:name,  :first_name) # Liste des attributs que vous utilisez
  end

end
