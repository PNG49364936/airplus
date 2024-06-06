import { Controller } from "stimulus";

export const updateRegistrations = (selectedHaulId, departureDate) => {
  console.log("Appel de la fonction updateRegistrations dans haul_flights_controller.js");
  console.log('departureeee', departureDate);
  console.log('selectedHaulId', selectedHaulId);
  
  return fetch(`/flights/available_registrations?departure_date=${departureDate}&haul_id=${selectedHaulId}`)
    .then(response => {
      console.log("response", response);
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      const registrationMessage = document.getElementById('registration-message');
      if (data.length === 0) {
        // Affiche le message personnalisé dans l'élément HTML
        registrationMessage.textContent = "Aucune immatriculation disponible pour la date et le haul sélectionnés.";
        registrationMessage.classList.remove('d-none');
      } else {
        registrationMessage.classList.add('d-none'); // Cache le message si data.length > 0
      }
    
      const registrationSelect = document.getElementById('registrationSelect');
      console.log("test13", registrationSelect);
      registrationSelect.innerHTML = '';
    
      data.forEach(registration => {
        const option = new Option(registration.reg, registration.id);
        console.log("test14", option);
        registrationSelect.appendChild(option);
      }); // Supprimez le point-virgule (;) ici
    
    })
    .catch(error => console.error("Error loading registrations:", error));
};

export default class extends Controller {
  static targets = ["haulSelect"];

  connect() {
    this.departureDate = null;
    this.selectedHaulId = null;
  }

  updateRegistrations(event) {
    this.selectedHaulId = event.target.value;
    const datesController = this.application.getControllerForElementAndIdentifier(
      document.querySelector('[data-controller="dates-flights"]'),
      "dates-flights"
    );

    if (datesController) {
      datesController.updateRegistrations();
    }
  }
}
