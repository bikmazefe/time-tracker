import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import "@fullcalendar/common/main.min.css";

window.addEventListener('turbolinks:load', function() {
    const calendarEl = document.getElementById('calendar');
    const loader = document.getElementById('loader');
    let entries = [];

    if(calendarEl){
        fetch('/profile/calendar.json')
        .then(res => res.json())
        .then(data => entries = [...data])
        .then(() => {
            setUpCalendar();
            loader.style.display = 'none';
        })
        .catch(err => console.error(err))
    }
    function setUpCalendar(){
        const calendar = new Calendar(calendarEl, {
                plugins: [dayGridPlugin],
                events: entries,
                eventTimeFormat: { 
                    hour: '2-digit',
                    minute: '2-digit',
                    hourCycle: 'h23',
                }
            });
        calendar.render();
    }
});
