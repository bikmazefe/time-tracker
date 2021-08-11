// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

window.addEventListener('turbolinks:load', () => {
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
    
            ongoing.innerText = `00:${getAdjustedValue(minutes)}:${getAdjustedValue(secs)}`;
            diffSeconds ++;
        }, 1000)
    }
    
    function getAdjustedValue(val) {
        return val < 10 ? '0' + val : val;
    }
})


require("css/application.scss")

import { Foundation } from 'foundation-sites'
import $ from 'jquery'

document.addEventListener('turbolinks:load', () => $(document).foundation());
