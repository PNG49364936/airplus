class StationsController < ApplicationController

    before_action :set_station, only: [:show, :edit, :update, :destroy]

    def index 
    @stations = Station.all
    end

    def show 
    end

    def new
        @station = Station.new
        @stations = Station.all
    end

    def create 
        @station = Station.new(params_station)
        if @station.save
            redirect_to @station, notice: 'Station is successfully created.'
        else
            render :new
        end
    end

    def edit
    end

    def update
    end

    def destroy
        @station.destroy
        redirect_to stations_url, notice: "station successfully destroyed"
    end

        private

        def set_station
            @station = Station.find(params[:id])
        end

        def params_station 
            params.require(:station).permit(:name, :haul, :airport_name)
        end

end
