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
  formatDate(date) {
    let month = '' + (date.getMonth() + 1);
    let day = '' + date.getDate();
    let year = '' + date.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [year, month, day].join('-');
  }

}