import { Controller } from "stimulus";
import flatpickr from "flatpickr";
import { updateRegistrations as haulFlightsUpdateRegistrations } from "./haul_flights_controller";

export default class extends Controller {
  static targets = ["range", "startDate", "endDate", "registration", "haulSelect"];

  connect() {
    console.log("Le contrôleur DatesFlights est connecté.");

    //if (this.hasRegistrationTarget) {
     // console.log("La cible d'immatriculation a été trouvée :", this.registrationTarget);
   // } else {
    //  console.log("La cible d'immatriculation n'a pas été trouvée.");
    //}

    this.initFlatpickr();
  }

  initFlatpickr() {
    flatpickr(this.rangeTarget, {
      mode: "range",
      dateFormat: "Y-m-d",
      minDate: "today",
      allowInput: true,
      enableTime: false,
      onClose: this.updateDates.bind(this)
    });
  }

  updateDates(selectedDates) {
    if (selectedDates.length === 2) {
      const formattedStartDate = this.formatDate(selectedDates[0]);
      const formattedEndDate = this.formatDate(selectedDates[1]);

      this.startDateTarget.value = formattedStartDate;
      this.endDateTarget.value = formattedEndDate;

      console.log("Date de départ formatée :", formattedStartDate);
      console.log("Date d'arrivée formatée :", formattedEndDate);

      // Mettre à jour les immatriculations disponibles en fonction de la date de départ sélectionnée
      this.updateRegistrations(formattedStartDate);
    }
  }

  updateRegistrations(departureDate) {
    const haulSelect = document.querySelector('#flight_haul_id');
    const selectedHaulId = haulSelect ? haulSelect.value : null;

    haulFlightsUpdateRegistrations(selectedHaulId, departureDate);
  }

  updateRegistrationSelect(data) {
    console.log("updateRegistrationSelect")
    const registrationSelect = this.registrationTarget;
    console.log('const registrationSelect',)
    registrationSelect.innerHTML = '';

    if (data.length === 0) {
      const noOption = new Option("Aucune immatriculation disponible", "");
      registrationSelect.appendChild(noOption);
    } else {
      const defaultOption = new Option("Choisir", "");
      registrationSelect.appendChild(defaultOption);

      data.forEach(registration => {
        const option = new Option(registration.reg, registration.id, registration.haul);
        registrationSelect.appendChild(option);
      });
    }
  }

  formatDate(date) {
    const dateInUTC = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));

    let day = dateInUTC.getUTCDate().toString().padStart(2, '0');
    let month = (dateInUTC.getUTCMonth() + 1).toString().padStart(2, '0');
    let year = dateInUTC.getUTCFullYear();

    return `${year}.${month}.${day}`;
  }
}
