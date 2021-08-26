import flatpickr from "flatpickr";
import 'flatpickr/dist/flatpickr.min.css';

document.addEventListener('turbolinks:load', () => {
    const startedAt = document.getElementById('entry_started_at');
    const finishTime = document.getElementById('entry_finish_time');

    if(startedAt && finishTime){
        flatpickr(document.getElementById('entry_started_at'), {
            altInput: true,
            altFormat: "F j, Y H:i",
            dateFormat: 'Y-m-d H:i',
            enableTime: true,
            minDate: 'today',
            time_24hr: true,
            defaultDate: Date.now(),
        });
        flatpickr(document.getElementById('entry_finish_time'), {
            enableTime: true,
            noCalendar: true,
            dateFormat: "H:i",
            time_24hr: true,
            defaultDate: Date.now(),
        });
    }
});