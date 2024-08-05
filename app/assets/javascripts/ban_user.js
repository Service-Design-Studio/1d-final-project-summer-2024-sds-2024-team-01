document.addEventListener('DOMContentLoaded', () => {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

  const handleAction = (buttonSelector, url, successMessage) => {
    document.querySelectorAll(buttonSelector).forEach(button => {
      button.addEventListener('click', event => {
        event.stopPropagation();  // Prevent card click event from firing
        event.preventDefault();
        const userId = event.target.getAttribute('data-user-id');
        
        fetch(url.replace(':id', userId), {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
          }
        })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            alert(successMessage);
            location.reload(); // Refresh the page to update the UI
          } else {
            alert('Action failed.');
          }
        });
      });
    });
  };

  handleAction('.ban-button', '/admin/ban_user/:id/ban', 'Successfully banned');
  handleAction('.unban-button', '/admin/ban_user/:id/unban', 'Successfully unbanned');
  handleAction('.cancel-ban-button', '/admin/ban_user/:id/cancel_ban', 'Successfully cancelled');

  // Handle card click to navigate to the user profile
  document.querySelectorAll('.user-card').forEach(card => {
    card.addEventListener('click', function(event) {
      if (event.target.tagName.toLowerCase() !== 'button' && event.target.tagName.toLowerCase() !== 'form') {
        const profileUrl = this.getAttribute('data-profile-url');
        console.log('Navigating to:', profileUrl); // Add this line to log the profile URL
        if (profileUrl) {
          window.location.href = profileUrl;
        } else {
          console.error('Profile URL is not defined');
        }
      }
    });
  });

  // Handle tab switching
  const tabLinks = document.querySelectorAll('#banUserTab a[data-toggle="tab"]');
  tabLinks.forEach(tabLink => {
    tabLink.addEventListener('shown.bs.tab', event => {
      const target = event.target.getAttribute('href');
      if (target === '#ban') {
        // Load the Ban Users content dynamically if needed
        console.log('Switched to Ban Users tab');
      } else if (target === '#unban') {
        // Load the Unban Users content dynamically if needed
        console.log('Switched to Unban Users tab');
      }
    });
  });
});
