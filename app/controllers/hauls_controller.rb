class HaulsController < ApplicationController

    before_action   :set_haul, only:[:show, :edit, :upgrade, :destroy]

def index 
    @hauls = Haul.all
end

def show 
end

def new 
    @hauls = Haul.all
    @haul = Haul.new
end 

def create
    @haul = Haul.new(params_haul)
    if @haul.save
        redirect_to @haul, notice: "Haul succesfully created"
        else
        render :new
    end
end

def edit
end

def upgrade
end

def destroy
    @haul.destroy
    redirect_to hauls_url, notice: "Haul destroyed"

end

private
    def set_haul
       @haul = Haul.find(params[:id]) 
    end

    def params_haul
        params.require(:haul).permit(:name)
    end

end
