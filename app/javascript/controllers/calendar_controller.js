import { Controller } from 'stimulus';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import "@fullcalendar/common/main.min.css";

export default class extends Controller {
    static targets = ['calendar', 'loader'];

    connect(){
        this.load();
    }    

    load(){
        fetch('/profile/calendar.json')
            .then(res => res.json())
            .then(data => {
                this.setupCalendar(data);
                if(this.hasLoaderTarget){
                    this.loaderTarget.style.display = "none";
                }
            })
            .catch(err => console.error(err))
    }

    setupCalendar(entries){
        const calendar = new Calendar(this.calendarTarget, {
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
}