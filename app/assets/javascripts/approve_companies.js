document.addEventListener("DOMContentLoaded", function() {
          const approveForms = document.querySelectorAll('.approve-form');
          const rejectForms = document.querySelectorAll('.reject-form');
          const companyCards = document.querySelectorAll('.company-card');
        
          approveForms.forEach(form => {
            form.addEventListener('submit', function(event) {
              event.preventDefault();
              const formData = new FormData(form);
              fetch(form.action, {
                method: 'POST',
                body: formData
              })
              .then(response => response.json())
              .then(data => {
                // Handle success response
                alert('Company approved successfully');
                // You can also update the UI here, for example, removing the approved card
              })
              .catch(error => {
                // Handle error response
                console.error('Error:', error);
                alert('Error approving company');
              });
            });
          });
        
          rejectForms.forEach(form => {
            form.addEventListener('submit', function(event) {
              event.preventDefault();
              const formData = new FormData(form);
              fetch(form.action, {
                method: 'POST',
                body: formData
              })
              .then(response => response.json())
              .then(data => {
                // Handle success response
                alert('Company rejected successfully');
                // You can also update the UI here, for example, removing the rejected card
              })
              .catch(error => {
                // Handle error response
                console.error('Error:', error);
                alert('Error rejecting company');
              });
            });
          });
        
          companyCards.forEach(card => {
            card.addEventListener('click', function() {
              const url = card.getAttribute('data-url');
              window.location.href = url;
            });
          });
        });
        