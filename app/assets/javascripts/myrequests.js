document.addEventListener('DOMContentLoaded', function() {
  const searchInput = document.getElementById('searchInput');
  const requestCards = document.querySelectorAll('.request-card_requests_index_my');

  searchInput.addEventListener('input', function() {
    const searchTerm = searchInput.value.toLowerCase().trim();
    requestCards.forEach(card => {
      const titleElement = card.querySelector('.card-title_requests_index_my');
      const title = titleElement ? titleElement.innerText.toLowerCase() : '';
      card.style.display = title.includes(searchTerm) ? 'block' : 'none';
    });
  });

  // Handle "Mark as Complete" button click
  document.querySelectorAll('.complete-form').forEach(form => {
    form.addEventListener('submit', function(event) {
      event.preventDefault();
      const requestCard = this.closest('.request-card_requests_index_my');
      const applicationIndicator = requestCard.querySelector('.application-indicator_requests_index_my');
      const reviewButton = requestCard.querySelector('.review-btn_mark_completed');

      // Update UI immediately
      applicationIndicator.style.display = 'none';
      this.style.display = 'none';
      reviewButton.classList.remove('d-none');

      // Update buttons for all applicants
      const applicantPopups = requestCard.querySelectorAll('.popup_requests_index_my');
      applicantPopups.forEach(popup => {
        const chatButton = popup.querySelector('.custom-btn-chat_my');
        const applicantInfo = popup.querySelector('.applicant-info_requests_index_my');
        const splitButton = popup.querySelector('.split-button_requests_index_my');
        const applicationStatus = splitButton.querySelector('.status-indicator_my')?.textContent.trim();

        // Remove chat button
        if (chatButton) chatButton.remove();

        // Add review button if the applicant was accepted
        if (applicationStatus === 'Accepted' && applicantInfo && !applicantInfo.querySelector('.leave-review-btn')) {
          const reviewButton = document.createElement('button');
          reviewButton.classList.add('btn', 'leave-review-btn');
          reviewButton.textContent = 'Leave a Review';
          applicantInfo.appendChild(reviewButton);
        }
      });

      // Update request card status
      requestCard.dataset.status = 'Completed';

      fetch(this.action, {
        method: this.method,
        body: new FormData(this),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
      })
      .then(response => response.json())
      .then(data => {
        if (!data.success) {
          // If the server returns an error, log it but don't revert the UI changes
          console.error(data.message);
        }
      })
      .catch(error => {
        // If there's an error, log it but don't revert the UI changes
        console.error('Error:', error);
      });
    });
  });

  // Function to check and update UI based on request status
  function updateUIBasedOnStatus() {
    document.querySelectorAll('.request-card_requests_index_my').forEach(card => {
      const status = card.dataset.status;
      const applicationIndicator = card.querySelector('.application-indicator_requests_index_my');
      const completeForm = card.querySelector('.complete-form');
      const reviewButton = card.querySelector('.review-btn_mark_completed');

      if (status === 'Completed') {
        // Hide elements for completed requests
        if (applicationIndicator) applicationIndicator.style.display = 'none';
        if (completeForm) completeForm.style.display = 'none';
        if (reviewButton) reviewButton.classList.remove('d-none');

        // Update buttons for all applicants
        const applicantPopups = card.querySelectorAll('.popup_requests_index_my');
        applicantPopups.forEach(popup => {
          const chatButton = popup.querySelector('.custom-btn-chat_my');
          const applicantInfo = popup.querySelector('.applicant-info_requests_index_my');
          const applicationStatus = popup.dataset.applicationStatus;

          // Remove chat button
          if (chatButton) chatButton.remove();

          // Add review button if the applicant was accepted
          if (applicationStatus === 'Accepted' && applicantInfo && !applicantInfo.querySelector('.leave-review-btn')) {
            const reviewButton = document.createElement('button');
            reviewButton.classList.add('btn', 'leave-review-btn');
            reviewButton.textContent = 'Leave a Review';
            applicantInfo.appendChild(reviewButton);
          }
        });
      } else {
        // For non-completed requests, ensure original state
        if (applicationIndicator) applicationIndicator.style.display = '';
        if (completeForm) completeForm.style.display = '';
        if (reviewButton) reviewButton.classList.add('d-none');

        // Ensure chat buttons are present for all applicants in non-completed requests
        const applicantPopups = card.querySelectorAll('.popup_requests_index_my');
        applicantPopups.forEach(popup => {
          const applicantInfo = popup.querySelector('.applicant-info_requests_index_my');
          let chatButton = popup.querySelector('.custom-btn-chat_my');
          const reviewButton = applicantInfo.querySelector('.leave-review-btn');

          // Add chat button if it doesn't exist
          if (!chatButton) {
            chatButton = document.createElement('button');
            chatButton.classList.add('btn', 'custom-btn-chat_my');
            chatButton.textContent = 'Chat';
            applicantInfo.appendChild(chatButton);
          }

          // Remove review button if it exists
          if (reviewButton) reviewButton.remove();
        });
      }
    });
  }

  // Call this function when the page loads
  updateUIBasedOnStatus();

  // Dropdown functionality
  const dropdownButtons = document.querySelectorAll('.dropdown-btn_requests_index_my');
  const cardBody = document.querySelector('.card-body');

  dropdownButtons.forEach(button => {
    button.addEventListener('click', (event) => {
      event.preventDefault();
      event.stopPropagation();
      const wrapper = button.closest('.clickable-card_requests_index-wrapper_my');
      const popupsContainer = wrapper.querySelector('.popups-container_my');
      
      // Close all other open popups
      document.querySelectorAll('.popups-container_my.active').forEach(container => {
        if (container !== popupsContainer) {
          closePopup(container);
        }
      });

      if (popupsContainer.classList.contains('active')) {
        closePopup(popupsContainer);
      } else {
        openPopup(popupsContainer);
      }

      // Adjust card body height
      setTimeout(() => {
        cardBody.style.height = cardBody.scrollHeight + 'px';
      }, 10);
    });
  });

  function openPopup(container) {
    container.classList.add('active');
    container.style.maxHeight = container.scrollHeight + 'px';
    const button = container.closest('.clickable-card_requests_index-wrapper_my').querySelector('.dropdown-btn_requests_index_my');
    button.innerHTML = '<i class="fas fa-chevron-up"></i>';
    container.closest('.clickable-card_requests_index-wrapper_my').style.marginBottom = container.scrollHeight + 'px';
  }

  function closePopup(container) {
    container.classList.remove('active');
    container.style.maxHeight = null;
    const button = container.closest('.clickable-card_requests_index-wrapper_my').querySelector('.dropdown-btn_requests_index_my');
    button.innerHTML = '<i class="fas fa-chevron-down"></i>';
    container.closest('.clickable-card_requests_index-wrapper_my').style.marginBottom = null;
  }

  // Close dropdown when clicking outside
  document.addEventListener('click', (event) => {
    if (!event.target.closest('.clickable-card_requests_index-wrapper_my')) {
      const openPopups = document.querySelectorAll('.popups-container_my.active');
      openPopups.forEach(closePopup);

      // Reset card body height
      cardBody.style.height = 'auto';
    }
  });

  // Handle form submissions and update the UI
  document.querySelectorAll('.accept-form, .reject-form').forEach(form => {
    form.addEventListener('submit', function(event) {
      event.preventDefault();
      const form = event.target;
      const action = form.getAttribute('action');
      const method = form.getAttribute('method');
      const formData = new FormData(form);
      const buttonContainer = form.closest('.split-button_requests_index_my');

      // Determine the new status based on which form was submitted
      const newStatus = form.classList.contains('accept-form') ? 'Accepted' : 'Rejected';

      // Immediately update the UI
      updateUI(buttonContainer, newStatus);

      // Immediately update the count
      updateApplicantCountImmediately(buttonContainer, newStatus);

      fetch(action, {
        method: method,
        body: formData,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
      })
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error('Network response was not ok.');
        }
      })
      .then(data => {
        // Confirm the UI update based on the server response
        updateUI(buttonContainer, data.status);
        // Update the applicant count based on the server response
        updateApplicantCountFromServer(buttonContainer, data.acceptedCount, data.numberOfPax);
      })
      .catch(error => {
        console.error('There was a problem with the fetch operation:', error);
        // Revert the UI change if there was an error
        revertUI(buttonContainer);
        // Revert the count change
        updateApplicantCountImmediately(buttonContainer, 'Revert');
      });
    });
  });

  function updateUI(container, status) {
    container.innerHTML = '';
    const indicator = document.createElement('div');
    indicator.classList.add('status-indicator_my', status.toLowerCase());
    indicator.textContent = status;
    container.appendChild(indicator);
  }

  function updateApplicantCountImmediately(container, status) {
    const cardWrapper = container.closest('.clickable-card_requests_index-wrapper_my');
    const statusIndicator = cardWrapper.querySelector('.applicants-status_requests_index_my');
    let acceptedCount = parseInt(statusIndicator.dataset.acceptedCount);
    const numberOfPax = parseInt(statusIndicator.dataset.numberOfPax);

    if (status === 'Accepted') {
      acceptedCount++;
    } else if (status === 'Rejected') {
      // Only decrease if it was previously accepted
      if (container.querySelector('.status-indicator_my.accepted')) {
        acceptedCount--;
      }
    } else if (status === 'Revert') {
      // If reverting an accept, decrease; if reverting a reject of a previously accepted application, increase
      if (container.querySelector('.status-indicator_my.accepted')) {
        acceptedCount--;
      } else if (container.querySelector('.status-indicator_my.rejected') && 
                container.closest('.popup_requests_index_my').querySelector('.status-indicator_my.accepted')) {
        acceptedCount++;
      }
    }

    updateApplicantCountUI(statusIndicator, acceptedCount, numberOfPax);
  }

  function updateApplicantCountFromServer(container, acceptedCount, numberOfPax) {
    const cardWrapper = container.closest('.clickable-card_requests_index-wrapper_my');
    const statusIndicator = cardWrapper.querySelector('.applicants-status_requests_index_my');
    updateApplicantCountUI(statusIndicator, acceptedCount, numberOfPax);
  }

  function updateApplicantCountUI(statusIndicator, acceptedCount, numberOfPax) {
    statusIndicator.dataset.acceptedCount = acceptedCount;
    statusIndicator.innerHTML = `<i class="fas fa-users"></i> ${acceptedCount}/${numberOfPax} people found`;

    // Change color to green if the count meets the number of pax
    if (acceptedCount >= numberOfPax) {
      statusIndicator.classList.add('full-capacity');
    } else {
      statusIndicator.classList.remove('full-capacity');
    }
  }
});