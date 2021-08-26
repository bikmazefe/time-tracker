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