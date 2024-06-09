import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["aircraftSelect", "aircraftMessage"];

  connect() {
    this.haulSelect = document.querySelector('#flight_haul_id');
    console.log('Le controleur aircrafts_flights_controller est connecté');
    if (this.haulSelect) {
      this.haulSelect.addEventListener('change', this.updateAircrafts.bind(this));
    }
  }

  updateAircrafts(event) {
    const selectedHaulId = event.target.value;
    console.log("event target value", selectedHaulId);
    if (selectedHaulId) {
      fetch(`/flights/available_aircrafts?haul_id=${selectedHaulId}`)
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          console.log('data****', data);
          const aircraftMessage = document.getElementById('registration-message');
          console.log('valeur aircraftMessage****', aircraftMessage)
          if (data.length === 0) {
            aircraftMessage.textContent = "Aucun appareil disponible pour le haul sélectionné.";
            aircraftMessage.classList.remove('d-none');
          } else {
            aircraftMessage.classList.add('d-none');
          }
          const aircraftSelect = document.getElementById('aircraftSelect');
        
          aircraftSelect.innerHTML = '';

          data.forEach(aircraft => {
            const option = new Option(aircraft.acft, aircraft.id);
            aircraftSelect.appendChild(option);
          });
        })
        .catch(error => console.error("Error loading aircrafts:", error));
    }
  }
}
