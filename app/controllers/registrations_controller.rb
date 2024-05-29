class RegistrationsController < ApplicationController
  
  
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @registrations = Registration.all
    
  end

  def show

  end

  def new
    @registration = Registration.new
    @registrations = Registration.all
    @hauls = Haul.all
 
    
  end

  def create
    @registration = Registration.new(params_registration)
        if @registration.save
            redirect_to @registration, notice: 'Registration was successfully created.'
          else
            @hauls = Haul.all
            render :new 
        end
  end

  def edit
  end

  def update
  end

  def destroy
    pp "A"*100
        if @registration.flights.any? 
          pp "B"*100
          flash[:alert] = "This registration is used by flights and cannot be deleted."
          else
            pp "C"*100
            @registration.destroy
            pp "D"*100
            flash[:notice] = "Registration was successfully deleted."
        end
        redirect_to registrations_url
  end
  
   
  
 

  private 
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def params_registration 
    params.require(:registration).permit(:reg, :haul_id)
    end

end
