class Flight < ApplicationRecord
    
    belongs_to :registration
    belongs_to :aircraft

    private
   
end
