import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["flightHaul", "departureStation", "arrivalStation"];

  connect() {
    this.updateStationsOnHaulChange();
  }

  updateStationsOnHaulChange() {
    this.flightHaulTarget.addEventListener('change', () => {
      const flightHaulValue = this.flightHaulTarget.value;
      this.updateStationOptions(this.departureStationTarget, flightHaulValue);
      this.updateStationOptions(this.arrivalStationTarget, flightHaulValue);
    });
  }

  updateStationOptions(stationSelect, flightHaul) {
    fetch(`/flights/stations?flight_haul=${flightHaul}`)
      .then(response => response.json())
      .then(data => {
        if (data.stations) {
          stationSelect.innerHTML = data.stations.map(station => {
            return `<option value="${station.id}">${station.name}</option>`;
          }).join('');
        }
      })
      .catch(error => console.error('Error:', error));
  }
}

