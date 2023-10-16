class RegistrationsController < ApplicationController
  
  
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @registrations = Registration.all
  end

  def show
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params_registration)
    if @registration.save
      redirect_to @registration, notice: 'Registration was successfully created.'
      else
      render :new
     end
  end

  def edit
  end

  def update
  end

  def destroy
    @registration.destroy
    redirect_to registrations_url, notice: 'Seats was successfully destroyed.'
  end

  private 
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def params_registration 
    params.require(:registration).permit(:reg)
    end

end
