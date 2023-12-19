class AirlineCodesController < ApplicationController

    before_action :set_airlinecode, only: [:destroy, :show]

        def index 
            @airlinecodes = AirlineCode.all
        end 

        def show
            @airlinecode = AirlineCode.find(params[:id])
          end

        def new 
            @airlinecode = AirlineCode.new
            @airlinecodes = AirlineCode.all
        end 

        def create 
            @airlinecode = AirlineCode.new(params_airlinecode)
            if @airlinecode.save
                pp @airlinecode.errors
                redirect_to @airlinecode, notice: "Airline code créé"
             else
                render :new
             end
        end 

        

        def destroy
            @airlinecode.destroy
            redirect_to airline_codes_url, notice: "Airline code destroyed"
        end

 private

        def set_airlinecode
            @airlinecode= AirlineCode.find(params[:id])
        end

        def params_airlinecode
            params.require(:airline_code).permit(:code) # Liste des attributs que vous utilisez
        end







end
