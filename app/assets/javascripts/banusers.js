document.addEventListener('DOMContentLoaded', function() {
          const banButtons = document.querySelectorAll('.ban-button');
          const unbanButtons = document.querySelectorAll('.unban-button');
        
          banButtons.forEach(button => {
            button.addEventListener('click', function() {
              const userId = this.dataset.userId;
              banUser(userId);
            });
          });
        
          unbanButtons.forEach(button => {
            button.addEventListener('click', function() {
              const userId = this.dataset.userId;
              unbanUser(userId);
            });
          });
        
          function banUser(userId) {
            // Make an AJAX call to ban the user
            fetch(`/admin/ban_user/${userId}/ban`, {
              method: 'PATCH',
              headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
              },
              body: JSON.stringify({ ban_reason: 'Violation of rules' })
            })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                // Update the UI to reflect the user has been banned
                document.querySelector(`#user-${userId}`).classList.add('banned');
              }
            })
            .catch(error => console.error('Error:', error));
          }
        
          function unbanUser(userId) {
            // Make an AJAX call to unban the user
            fetch(`/admin/ban_user/${userId}/unban`, {
              method: 'PATCH',
              headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
              }
            })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                // Update the UI to reflect the user has been unbanned
                document.querySelector(`#user-${userId}`).classList.remove('banned');
              }
            })
            .catch(error => console.error('Error:', error));
          }
        });
        