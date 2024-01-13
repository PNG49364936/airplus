class Geocoding < ApplicationRecord
before_validation :upcase_placename







private

def placename
    self.place_name = place_name.upcase if cbn.present?
end




end
