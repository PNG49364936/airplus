class AircraftsController < ApplicationController

    before_action :set_aircraft, only: [:show, :edit, :update, :destroy]

    


    def index
        @aircrafts = Aircraft.all
    end

    def show
    end

    def new
     @aircraft = Aircraft.new
    end

    def create 
        @aircraft = Aircraft.new(params_aircraft)
       if @aircraft.save
        redirect_to @aircraft, notice: 'Aircraft was successfully created.'
        else
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
        @aircraft.destroy
        redirect_to aircrafts_url, notice: 'Aircraft was successfully destroyed.'
    end

    private

        def set_aircraft
            @aircraft = Aircraft.find(params[:id])
        end

        def params_aircraft
            params.require(:aircraft).permit(:acft, :aircraft_class, :seats, :registration) # Liste des attributs que vous utilisez
        end
    


end
