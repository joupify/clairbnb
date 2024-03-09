import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  connect() {
    this.initializeMap();
  }

  initializeMap() {
    const mapOptions = {
      center: { lat: -34.397, lng: 150.644 },
      zoom: 8
    };
    const mapElement = this.element;
    const map = new google.maps.Map(mapElement, mapOptions);
  }
  
}
