document.addEventListener('turbolinks:load', () => {
    const ongoing = document.getElementById('ongoing-duration');

    if(ongoing){
        const startedAt = ongoing.dataset.startedAt;
        const currentDuration = Math.abs(new Date - Date.parse(startedAt));
        let diffSeconds = Math.ceil(currentDuration / 1000);
    
        setInterval(() => {
            let secs = diffSeconds;
    
            const hours = Math.floor(secs / 3600);
            secs -= hours * 3600;
    
            const minutes = Math.floor(secs / 60);
            secs -= minutes * 60;
    
            ongoing.innerText = `${getAdjustedValue(hours)}:${getAdjustedValue(minutes)}:${getAdjustedValue(secs)}`;
            diffSeconds ++;
        }, 1000);
    }    
})

function getAdjustedValue(val) {
    return val < 10 ? '0' + val : val;
}