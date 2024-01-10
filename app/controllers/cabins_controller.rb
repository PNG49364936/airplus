class CabinsController < ApplicationController
    before_action :set_cabin, only: [:show, :edit, :update, :destroy]

def index
    @cabins = Cabin.all
end

def show
end

def new 
    @cabin = Cabin.new
    @cabins = Cabin.all
end

def create
    @cabin = Cabin.new(params_cabin)
    if @cabin.save
        redirect_to @cabin, notice: 'Cabin was successfully created.'
        else
        render :new
    end
end

def edit
end

def update
end

def destroy
    if @cabin.flights.any?
        flash[:alert] = "This cabin is used by flights and cannot be deleted."
        else
          @cabin.destroy
          flash[:notice] = "Cabin was successfully deleted."
      end
      redirect_to cabins_url
end


private

def set_cabin
    @cabin = Cabin.find(params[:id])
end

def params_cabin
   params.require(:cabin).permit(:cbn)
end



end
