import { Controller } from "stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["range", "startDate", "endDate", "registration"];
  
  connect() {
    console.log("DatesFlightsController connected");
    this.initFlatpickr();
  }

  initFlatpickr() {
    flatpickr(this.rangeTarget, {
      mode: "range",
      dateFormat: "Y-m-d",
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
      
      console.log("Formatted Start Date:", formattedStartDate);
      console.log("Formatted End Date:", formattedEndDate);

      // Appel pour mettre à jour les immatriculations disponibles basé sur la date de départ sélectionnée
      this.updateRegistrations();
    }
  }

  updateRegistrations() {
    const departureDate = this.startDateTarget.value;
    fetch(`/flights/available_registrations?departure_date=${departureDate}`)
      .then(response => response.json())
      .then(data => {
        console.log("data",data)
        // 'data' est ici l'équivalent de votre 'available_registrations'
        // Utilisez 'data' pour mettre à jour l'interface utilisateur
        this.updateRegistrationSelect(data); // Assurez-vous que cette méthode traite correctement 'data'
      })
      .catch(error => console.error("Error loading registrations:", error));
  }
  
  



  

  formatDate(date) {
    return date.toISOString().split('T')[0]; // Format simplifié pour la date
  }
}
