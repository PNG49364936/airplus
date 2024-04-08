import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ["flightHaul","registration"];

connect() {
console.log("test haul")
this.updateRegistrationOnHaulChange()
}
updateRegistrationOnHaulChange(){
    console.log("test haul1")
    this.RegistrationHaulTarget.addEventListener('change', () => {
        console.log("test haul2")  
    const registrationHaulValue = this.registrationHaulTarget.value;
    this.updateRegistrationOptions(this.registrationTarget, registrationHaulValue);
        console.log("registration value")
        console.log (this.registrationHaulValue)
    });

}



}