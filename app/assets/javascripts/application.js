
document.addEventListener('DOMContentLoaded', function() {
  console.log("DOM fully loaded");

  // Function to remove a flash message
  function removeFlash(flash) {
    flash.style.opacity = '0';
    setTimeout(function() {
      flash.remove();
    }, 300);
  }

  // Handle all flash messages
  var flashMessages = document.querySelectorAll('.alert');
  flashMessages.forEach(function(flash) {
    console.log("Processing flash message:", flash);

    // Set timeout for auto-removal
    setTimeout(function() {
      removeFlash(flash);
    }, 5000);

    // Set up close button
    var closeButton = flash.querySelector('.close');
    if (closeButton) {
      closeButton.addEventListener('click', function(e) {
        e.preventDefault();
        console.log("Close button clicked");
        removeFlash(flash);
      });
    }
  });
});