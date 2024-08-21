import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["aircraftSelect"];

  connect() {
    this.haulSelect = document.querySelector('#flight_haul_id');
    this.haulSelect.addEventListener('change', this.updateAircrafts.bind(this));
  }

  updateAircrafts(event) {
    const selectedHaulId = event.target.value;
    if (selectedHaulId) {
      fetch(`/available_aircrafts?haul_id=${selectedHaulId}`)
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          const aircraftMessage = document.getElementById('aircraft-message');
          if (data.length === 0) {
            // Affiche le message personnalisé dans l'élément HTML
            aircraftMessage.textContent = "Aucun appareil disponible pour le haul sélectionné.";
            aircraftMessage.classList.remove('d-none');
          } else {
            aircraftMessage.classList.add('d-none'); // Cache le message si data.length > 0
          }

          const aircraftSelect = this.aircraftSelectTarget;
          console.log("test13", aircraftSelect);
          aircraftSelect.innerHTML = '';

          data.forEach(aircraft => {
            const option = new Option(aircraft.acft, aircraft.id);
            console.log("test14", option);
            aircraftSelect.appendChild(option);
          });
        })
        .catch(error => console.error("Error loading aircrafts:", error));
    }
  }
}