import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    const unavailableDates = this.element.dataset.unavailableDates.split(',').map(date => new Date(date));
    
    flatpickr(this.element, {
      dateFormat: "Y-m-d", 
      disable: unavailableDates,
      onChange: this.handleDateChange.bind(this)
    });
  }

  handleDateChange(selectedDates, dateStr, instance) {
    const disabledDates = instance.days.querySelectorAll(".flatpickr-disabled");

    disabledDates.forEach(date => {
      date.classList.add("grayed-out");
    });
  }
}
