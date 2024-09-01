import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form"];

  reset(event) {
    console.log("Réinitialisation du formulaire 0");
    event.preventDefault();
    console.log("Réinitialisation du formulaire 1");
    this.formTarget.reset();
    console.log("Réinitialisation du formulaire 2");

    // Réinitialiser manuellement les collection_select
    this.formTarget.querySelectorAll('select').forEach(select => {
      console.log("Réinitialisation du formulaire 3");
      select.selectedIndex = 0;
      console.log("Réinitialisation du formulaire 4");
    });

    // Réinitialiser manuellement les date_select
    this.formTarget.querySelectorAll('input[type="date"]').forEach(dateInput => {
      dateInput.value = '';
    });
  }
}