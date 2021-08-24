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



require("css/application.scss")

import "@fortawesome/fontawesome-free/js/all.min.js"

import 'foundation-sites/dist/js/foundation.min.js'
import $ from 'jquery'

$(document).on('ready turbolinks:load', () => $(document).foundation());


// Hide flash after 5 seconds.
function hideFlash() {
  setInterval(function() {
    let flashWrapper = document.querySelector('.flash-wrapper');
    if(flashWrapper){
      flashWrapper.classList.add('exit');
      setTimeout(() => flashWrapper.style.display = 'none', 500);
    }
  }, 5000);
}
    
hideFlash();