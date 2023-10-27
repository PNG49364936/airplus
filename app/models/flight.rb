class Flight < ApplicationRecord
    
    belongs_to :registration
    belongs_to :aircraft
    belongs_to :haul
    belongs_to :cabin

    private
   
end
