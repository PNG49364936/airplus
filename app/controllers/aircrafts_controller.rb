class AircraftsController < ApplicationController

    before_action :set_aircraft, only: [:show, :edit, :update, :destroy]

    


    def index
        @aircrafts = Aircraft.all
    end

    def show
    end

    def new
    @aircrafts = Aircraft.all
    @aircraft = Aircraft.new
    @hauls = Haul.all
   
    
    end

    def create 
        @aircraft = Aircraft.new(params_aircraft)
       if @aircraft.save
        redirect_to @aircraft, notice: 'Aircraft was successfully created.'
        else
             @hauls = Haul.all
            render :new

       end
    end

    def edit
    end

    def update
        if @aircraft.update(params_aircraft)
            redirect_to @aircraft, notice: 'Aircraft was successfully updated.'
          else
            render :edit
          end
    end

    def destroy
      
            pp "A"*100
                if @aircraft.flights.any?
                  flash[:alert] = "This aircraft is used by flights and cannot be deleted."
                  else
                    @aircraft.destroy
                    flash[:notice] = "Aircraft type was successfully deleted."
                end
                redirect_to aircrafts_url
             
    end

    private

        def set_aircraft
            @aircraft = Aircraft.find(params[:id])
        end

        def params_aircraft
            params.require(:aircraft).permit(:acft, :aircraft_class, :seats, :registration, :haul, :haul_id) # Liste des attributs que vous utilisez
        end
    


end
