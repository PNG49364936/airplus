class FlightNumbersController < ApplicationController

    def index 
        @flightnumbers =  FlightNumber.all
    end

    def show 
    end

    def new 
        @flightnumber = FlightNumber.new
    end
    
    def create 
        @flightnumber = FlightNumber.create(flight_number_params)
        if @flightnumber.save
            redirect_to @flightnumber
        else
            render :new
        end
    end

    def edit
    end

    def destroy
        @flightnumber.destroy
        redirect_to flightnumbers_path
    end

    def update
    end

    private

    def flight_number_params
        # Assurez-vous d'avoir une méthode strong params pour sécuriser les attributs acceptés
        params.require(:flight_number).permit(:code, :number)
      end

end