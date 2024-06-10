import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset"
export default class extends Controller {
  reset() {
    
    this.element.reset();

    
  }
}
