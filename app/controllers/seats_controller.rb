class SeatsController < ApplicationController
  
  before_action :set_seat, only: [:show, :edit, :update, :destroy]
  
  def index
    @seats = Seat.all
  end

  def show
  end

  def new
    @seat = Seat.new
  end

  def create
    @seat = Seat.new(params_seat)
    if @seat.save
     redirect_to @seat, notice: 'Seats number was successfully created.'
     else
     render :new
    end

  end

  def edit
  end

  def destroy
    @seat.destroy
    redirect_to seats_url, notice: 'Seats was successfully destroyed.'
  end

  private
  def set_seat
    @seat = Seat.find(params[:id])
  end

def params_seat
    params.require(:seat).permit(:number) # Liste des attributs que vous utilisez
end




end
