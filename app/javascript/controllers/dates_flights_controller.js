import { Controller } from "stimulus";
import flatpickr from "flatpickr";
import { updateRegistrations as haulFlightsUpdateRegistrations } from "./haul_flights_controller";

export default class extends Controller {
  static targets = ["range", "startDate", "endDate", "registration", "haulSelect"];

  connect() {
    console.log("Le contrôleur DatesFlights est connecté.");
    this.departureDate = null;
    this.selectedHaulId = null;
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

      this.departureDate = formattedStartDate;
      this.updateRegistrations();
    }
  }

  updateRegistrations() {
    console.log("controlleur update registrations")
    const haulSelect = document.querySelector('#flight_haul_id');
    this.selectedHaulId = haulSelect ? haulSelect.value : null;
    console.log("selectedHaulId", this.selectedHaulId);

    if (this.departureDate && this.selectedHaulId) {
      haulFlightsUpdateRegistrations(this.selectedHaulId, this.departureDate);
    }
  }

  formatDate(date) {
    const dateInUTC = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));

    let day = dateInUTC.getUTCDate().toString().padStart(2, '0');
    let month = (dateInUTC.getUTCMonth() + 1).toString().padStart(2, '0');
    let year = dateInUTC.getUTCFullYear();

    return `${year}-${month}-${day}`;
  }
}
