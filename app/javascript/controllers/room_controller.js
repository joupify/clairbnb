import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room"
export default class extends Controller {
  static targets = [
    'bedFields',
    'beds',
  ]
  connect() {
    console.log("room connected");
  }

  addBed(e) {
    console.log(this.bedFieldsTarget.innerHTML);
    e.preventDefault()
  this.bedsTarget.insertAdjacentHTML(
    'beforeend',
    this.bedFieldsTarget.innerHTML
  )

  }
}
