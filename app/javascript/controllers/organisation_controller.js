import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="organisation"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("fancy")

  }

  // toggleForm(event) {
  //   // console.log("helloww")
  //   // console.log(this.formTargets)
  //   const selected = this.formTargets.find((element) => element.dataset.formid === event.currentTarget.dataset.button)
  //   console.log(selected)
  //   selected.classList.toggle('invisible')

  // }

  toggleForm(event) {
    // console.log("helloww")
    // console.log(this.formTargets)
   this.formTarget.classList.toggle('invisible')

  }
}
