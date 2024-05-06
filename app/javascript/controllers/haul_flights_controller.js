import { Controller } from "stimulus";

export const updateRegistrations = (selectedHaulId, departureDate) => {
    console.log("Appel de la fonction updateRegistrations dans haul_flights_controller.js");
    console.log('test11')
  return fetch(`/flights/available_registrations?departure_date=${departureDate}&haul_id=${selectedHaulId}`)
    
  .then(response => {
    
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
        console.log("donnees", data)
        const registrationSelect = document.getElementById('registrationSelect');
        console.log("test13",registrationSelect)
        registrationSelect.innerHTML = '';
  
        data.forEach(registration => {
          const option = new Option(registration.reg, registration.id);
          console.log("test14",option)
          registrationSelect.appendChild(option);
        });
      })
    .catch(error => console.error("Error loading registrations:", error));
};
