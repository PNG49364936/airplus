class AirlineCodesController < ApplicationController
    before_action :set_airline_code, only: [:show, :destroy]
  
    def index 
      @airline_codes = AirlineCode.all
    end 
  
    def show
      # @airline_code is set by the set_airline_code before_action
    end
  
    def new 
      @airline_code = AirlineCode.new
      @airline_codes = AirlineCode.all
    end 
  
    def create 
      @airline_code = AirlineCode.new(airline_code_params)
      if @airline_code.save
        redirect_to @airline_code, notice: "Airline code créé"
      else
        render :new
      end
    end 
  
    def destroy
      @airline_code.destroy
      redirect_to airline_codes_url, notice: "Airline code destroyed"
    end
  
    private
  
    def set_airline_code
      @airline_code = AirlineCode.find(params[:id])
    end
  
    def airline_code_params
      params.require(:airline_code).permit(:code)
    end
  end
  