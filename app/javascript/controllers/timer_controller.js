import { Controller } from 'stimulus';

export default class extends Controller {
    static targets = ["ongoing"]

    connect(){
        if (this.hasOngoingTarget) {
            const { startedAt } = this.ongoingTarget.dataset;
            this.startTimer(startedAt);
        }
    }

    getAdjustedValue(val) {
        return val < 10 ? '0' + val : val;
    }

    currentDurationInSeconds(startedAt){
        const diff = Math.abs(new Date - Date.parse(startedAt));
        return Math.ceil(diff / 1000);
    }

    updateTimer(hours, minutes, secs){
        this.ongoingTarget.innerText = `${this.getAdjustedValue(hours)}:${this.getAdjustedValue(minutes)}:${this.getAdjustedValue(secs)}`;
    }

    startTimer(startedAt){
        let currentSecs = this.currentDurationInSeconds(startedAt);
    
        setInterval(() => {
            let secs = currentSecs;

            const hours = Math.floor(secs / 3600);
            secs -= hours * 3600;
    
            const minutes = Math.floor(secs / 60);
            secs -= minutes * 60;
            
            this.updateTimer(hours, minutes, secs);
            currentSecs ++;
        }, 1000);
    }
}
