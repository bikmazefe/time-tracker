import 'flatpickr/dist/flatpickr.min.css';
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "picker" ]

  connect() {
      if(this.hasPickerTarget){
        import("flatpickr")
          .then((flatpickr) => {
            this.flatpickr = flatpickr.default;
          })
          .then(() => this.setupPickers());
      }
  }

  setupPickers(){
    this.pickerTargets.forEach(element => {
      let opts = this.getPickerAttributes(element);
      this.flatpickr(element, opts);
  });
  }

  getPickerAttributes(el){  
    const {
      enableTime, 
      defaultDate, 
      minTime, 
      maxTime,
      minDate,
      maxDate,
      noCalendar,
    } = el.dataset;

    const format = () => {
      if (noCalendar && enableTime) return "H:i";
      if (enableTime) return "F j, Y H:i";

      return "F j, Y";
    }
    
    return {
      altInput: true,
      altFormat: format(),
      dateFormat: 'Y-m-d H:i',
      time_24hr: true, 
      defaultDate,
      enableTime,
      noCalendar,
      minDate,
      maxDate,
      minTime,
      maxTime,
    };
  }
}
