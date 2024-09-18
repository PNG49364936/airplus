import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.resultsContainer = document.querySelector('.index.row.col-12')
    this.flightsTable = this.resultsContainer.querySelector('table')
  }

  reset(event) {
    event.preventDefault()
    this.formTarget.reset()

    // Réinitialiser manuellement les collection_select
    this.formTarget.querySelectorAll('select').forEach(select => {
      select.selectedIndex = 0
    })

    // Réinitialiser manuellement les date_select
    this.formTarget.querySelectorAll('input[type="date"]').forEach(dateInput => {
      dateInput.value = ''
    })

    // Vider le tableau des résultats
    this.clearResults()
  }

  clearResults() {
    fetch('/customers/reset_search', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Accept': 'application/json'
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === 'success') {
        // Préserver l'en-tête avec ses styles et vider le reste du tableau
        const headerRow = this.flightsTable.rows[0];
        const newBody = document.createElement('tbody');
        newBody.className = 'search';
        
        // Vider le contenu du tableau tout en préservant l'en-tête
        while (this.flightsTable.rows.length > 1) {
          this.flightsTable.deleteRow(1);
        }
        
        // Ajouter le nouveau corps vide
        if (this.flightsTable.tBodies.length > 0) {
          this.flightsTable.replaceChild(newBody, this.flightsTable.tBodies[0]);
        } else {
          this.flightsTable.appendChild(newBody);
        }
      }
    })
    .catch(error => console.error('Error:', error))
  }
}