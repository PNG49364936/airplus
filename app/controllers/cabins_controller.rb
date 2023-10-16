class CabinsController < ApplicationController
    before_action :set_cabin, only: [:show, :edit, :update, :destroy]

def index
    @cabins = Cabin.all
end

def show
end

def new 
    @cabin = Cabin.new
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
    @cabin.destroy
    redirect_to cabins_url, notice: 'Cabin was successfully destroyed.'
end


private

def set_cabin
    @cabin = Cabin.find(params[:id])
end

def params_cabin
   params.require(:cabin).permit(:cbn)
end



end
