import { Controller } from "stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["range", "startDate", "endDate", "registration"];
  
  connect() {
    console.log("DatesFlightsController connected");
    console.log("Has registration target:", this.hasRegistrationTarget); // Vérifie si l'élément cible est accessible
    if (this.hasRegistrationTarget) {
      console.log("Registration target found:", this.registrationTarget);
    } else {
      console.log("Registration target not found.");
    }
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

      console.log("Formatted Start Date:", formattedStartDate);
      console.log("Formatted End Date:", formattedEndDate);

      // Appel pour mettre à jour les immatriculations disponibles basé sur la date de départ sélectionnée
      this.updateRegistrations();
    }
 
  }
  updateRegistrations() {
    const departureDate = this.startDateTarget.value;
    console.log(`Fetching registrations for departure date: ${departureDate}`); // Pour déboguer
    fetch(`/flights/available_registrations?departure_date=${departureDate}`)
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        console.log("Received data:", data); // Pour déboguer
        console.log("ok")
        this.updateRegistrationSelect(data);
     
    
      })
    .catch(error => console.error("Error loading registrations:", error));
  }
  
  updateRegistrationSelect(data) {
    
    const registrationSelect = document.getElementById('registrationSelect');
    registrationSelect.innerHTML = '';
    if (data.length === 0) {
      // Si l'array est vide, créez une option qui affiche le message "Pas d'immatriculation disponible"
      const noOption = new Option("Pas d'immatriculation disponible", "");
    registrationSelect.appendChild(noOption);
    } else{
    const defaultOption = new Option("Choisir", "");
    registrationSelect.appendChild(defaultOption);
    data.forEach(registration => {
      const option = new Option(registration.reg, registration.id);
      registrationSelect.appendChild(option);
    });
  }}

  formatDate(date) {
    // Créez un nouvel objet Date avec la date sélectionnée ajustée à UTC
    const dateInUTC = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
  
    // Formatez la date en 'YYYY.MM.DD'
    let day = dateInUTC.getUTCDate().toString().padStart(2, '0');
    let month = (dateInUTC.getUTCMonth() + 1).toString().padStart(2, '0'); // Les mois sont de 0 à 11 en JS
    let year = dateInUTC.getUTCFullYear();
  
    return `${year}.${month}.${day}`;
  }
}