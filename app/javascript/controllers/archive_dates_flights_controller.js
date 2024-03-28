import { Controller } from "stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["range", "startDate", "endDate"];

  connect() {
    console.log("DatesFlightsController connected");
    console.log("hello1");
    this.startFlatpickr = flatpickr(this.rangeTarget, {
      mode: "range",
      dateFormat: "Y.m.d",
      allowInput: true,
      enableTime: false,
      onClose: this.updateDates.bind(this)
    });
  }

  updateDates(selectedDates) {
    console.log("hello2");
    if (selectedDates.length === 2) {
        console.log("hello3");
      // Formatez les dates
      const formattedStartDate = this.formatDate(selectedDates[0]);
      const formattedEndDate = this.formatDate(selectedDates[1]);
  
      // Affectez les valeurs formatées aux champs cachés
      console.log("hello4");
      this.startDateTarget.value = formattedStartDate;
      this.endDateTarget.value = formattedEndDate;
  
      // Utilisez console.log pour afficher les valeurs formatées
      console.log("Formatted Start Date:", formattedStartDate);
      console.log("Formatted End Date:", formattedEndDate);
    }
  }
  updateRegistrationSelect(data) {
    console.log("test1")
    const registrationSelect = this.registrationTarget;
    console.log("test2")
    registrationSelect.innerHTML = '';

    const options = data.map(registration => {
        // Utilisation explicite du mot-clé return pour la clarté
        return `<option value="${registration.id}">${registration.reg}</option>`;
    }).join('');
    
    registrationSelect.innerHTML = options;
}

  formatDate(date) {
    return date.toISOString().split('T')[0];
  }
  connect() {
    console.log("DatesFlightsController connected");
    console.log(this.hasRegistrationTarget); // Vérifie si l'élément cible est accessible
    if (this.hasRegistrationTarget) {
      console.log("Registration target found:", this.registrationTarget);
    } else {
      console.log("Registration target not found.");
    }
  }
}

  
  



