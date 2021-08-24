import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import "@fullcalendar/common/main.min.css";

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    let entries = [];

    fetch('/profile/calendar.json')
        .then(res => res.json())
        .then(data => entries = [...data])
        .then(() => setUpCalendar())
        .catch(err => console.error(err))

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
  