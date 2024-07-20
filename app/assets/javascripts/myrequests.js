document.addEventListener('DOMContentLoaded', function() {
  initializeMyRequests();
});

function initializeMyRequests() {
  const requestContainer = document.getElementById('requestContainer');
  const searchInput = document.getElementById('searchInput');
  const cardBody = document.querySelector('.card-body');

  // Search functionality
  if (searchInput) {
    searchInput.addEventListener('input', performSearch);
  }

  // Use event delegation for dynamically loaded content
  if (requestContainer) {
    requestContainer.addEventListener('click', handleRequestContainerClick);
  }

  // Initialize tab functionality
  initializeTabs();

  // Call this function when the page loads
  updateUIBasedOnStatus();
  hideEmptyDropdowns();

  // Close dropdown when clicking outside
  document.addEventListener('click', handleOutsideClick);
}

function performSearch() {
  const searchTerm = this.value.toLowerCase().trim();
  document.querySelectorAll('.request-card_requests_index_my').forEach(card => {
    const titleElement = card.querySelector('.card-title_requests_index_my');
    const title = titleElement ? titleElement.innerText.toLowerCase() : '';
    card.style.display = title.includes(searchTerm) ? 'block' : 'none';
  });
}

function handleRequestContainerClick(event) {
  // Handle "Mark as Complete" button click
  if (event.target.closest('.complete-form')) {
    event.preventDefault();
    handleCompleteForm(event.target.closest('.complete-form'));
  }

  // Handle dropdown button click
  if (event.target.closest('.dropdown-btn_requests_index_my')) {
    event.preventDefault();
    handleDropdownClick(event.target.closest('.dropdown-btn_requests_index_my'));
  }

  // Handle accept/reject form submissions
  if (event.target.closest('.accept-form, .reject-form')) {
    event.preventDefault();
    handleAcceptRejectForm(event.target.closest('.accept-form, .reject-form'));
  }

  // Handle "Repost" button click
  if (event.target.closest('.repost-btn_unfulfilled')) {
    event.preventDefault();
    const repostButton = event.target.closest('.repost-btn_unfulfilled');
    const requestId = repostButton.dataset.requestId;
    window.location.href = `/requests/${requestId}/edit`;
  }

}

function initializeTabs() {
  const tabButtons = document.querySelectorAll('#myRequestsTabs button');
  tabButtons.forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault();
      switchTab(this);
    });
  });
}

function switchTab(tabButton) {
  const tabId = tabButton.getAttribute('data-bs-target').replace('#', '');
  
  // Remove active class from all tabs
  const tabButtons = document.querySelectorAll('#myRequestsTabs button');
  tabButtons.forEach(btn => {
    btn.classList.remove('active');
    btn.setAttribute('aria-selected', 'false');
  });

  // Add active class to clicked tab
  tabButton.classList.add('active');
  tabButton.setAttribute('aria-selected', 'true');

  // Hide all tab panes
  document.querySelectorAll('.tab-pane').forEach(pane => {
    pane.classList.remove('show', 'active');
  });

  // Show the selected tab pane
  const selectedPane = document.querySelector(tabButton.getAttribute('data-bs-target'));
  selectedPane.classList.add('show', 'active');

  updateRequestCards(tabId);
}

function updateRequestCards(tabId) {
  fetch(`/myrequests?tab=${tabId}`, {
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    }
  })
  .then(response => response.json())
  .then(data => {
    const tabPane = document.querySelector(`#${tabId}`);
    tabPane.innerHTML = data.html;
    // Update UI based on the new tab content
    updateUIBasedOnStatus();
    // Dispatch a custom event after content is loaded
    document.dispatchEvent(new CustomEvent('requestCardsUpdated', { detail: { tabId: tabId } }));
  });
}

function handleCompleteForm(form) {
  const requestCard = form.closest('.request-card_requests_index_my');
  const applicationIndicator = requestCard.querySelector('.application-indicator_requests_index_my');
  const reviewButton = requestCard.querySelector('.review-btn_mark_completed');
  const repostButton = requestCard.querySelector('.repost-btn_unfulfilled');

  // Update UI immediately
  applicationIndicator.style.display = 'none';
  form.style.display = 'none';

  // Check if the request is unfulfilled (you may need to add a check here based on your criteria)
  const isUnfulfilled = checkIfUnfulfilled(requestCard);

  if (isUnfulfilled) {
    repostButton.classList.remove('d-none');
  } else {
    reviewButton.classList.remove('d-none');
  }
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

  // Prepare for smooth transition
  requestCard.style.transition = 'opacity 0.5s ease-out';
  requestCard.style.opacity = '0';

  setTimeout(() => {
    // Move the card to the top of the Completed tab
    const completedTabPane = document.querySelector('#completed');
    const firstChild = completedTabPane.firstChild;
    completedTabPane.insertBefore(requestCard, firstChild);

    // Switch to the Completed tab
    const completedTabButton = document.querySelector('[data-bs-target="#completed"]');
    switchTab(completedTabButton);

    // Fade the card back in
    setTimeout(() => {
      requestCard.style.opacity = '1';
    }, 50);
  }, 500);

  fetch(form.action, {
    method: form.method,
    body: new FormData(form),
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    }
  })
  .then(response => response.json())
  .then(data => {
    if (!data.success) {
      console.error(data.message);
    }
  })
  .catch(error => {
    console.error('Error:', error);
  });
}

// function checkIfUnfulfilled(requestCard) {
//   const status = requestCard.dataset.status;
//   const requestDate = new Date(requestCard.dataset.date);
//   const requestTime = requestCard.dataset.time;
//   const [hours, minutes] = requestTime.split(':').map(Number);
//   requestDate.setHours(hours, minutes);

//   const now = new Date();

  
//   return status !== 'Completed' && requestDate < now;
// }

function handleDropdownClick(button) {
  const wrapper = button.closest('.clickable-card_requests_index-wrapper_my');
  const popupsContainer = wrapper.querySelector('.popups-container_my');
  const cardBody = document.querySelector('.card-body');
  
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

  // Adjust card body height immediately
  if (cardBody) cardBody.style.height = cardBody.scrollHeight + 'px';
}
  
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

function handleOutsideClick(event) {
  if (!event.target.closest('.clickable-card_requests_index-wrapper_my')) {
    const openPopups = document.querySelectorAll('.popups-container_my.active');
    openPopups.forEach(closePopup);

    // Reset card body height
    const cardBody = document.querySelector('.card-body');
    if (cardBody) cardBody.style.height = 'auto';
  }
}

function hideEmptyDropdowns() {
  document.querySelectorAll('.request-card_requests_index_my').forEach(card => {
    const applicantPopups = card.querySelectorAll('.popup_requests_index_my');
    const totalApplicants = applicantPopups.length;
    const dropdownButton = card.querySelector('.dropdown-btn_requests_index_my');
    
    if (totalApplicants === 0 && dropdownButton) {
      dropdownButton.style.display = 'none';
    } else if (dropdownButton) {
      dropdownButton.style.display = 'block';
    }
  });
}


function handleAcceptRejectForm(form) {
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
}

function updateUIBasedOnStatus() {
  document.querySelectorAll('.request-card_requests_index_my').forEach(card => {
    const applicationIndicator = card.querySelector('.application-indicator_requests_index_my');
    const completeForm = card.querySelector('.complete-form');
    const reviewButton = card.querySelector('.review-btn_mark_completed');
    const repostButton = card.querySelector('.repost-btn_unfulfilled');

    const currentTab = card.closest('.tab-pane').id;

    if (currentTab === 'completed') {
      // For completed requests
      if (applicationIndicator) applicationIndicator.style.display = 'none';
      if (completeForm) completeForm.style.display = 'none';
      if (repostButton) repostButton.classList.add('d-none');
      if (reviewButton) reviewButton.classList.remove('d-none');

      updateApplicantButtonsForCompleted(card);
    } else if (currentTab === 'unfulfilled') {
      // For unfulfilled requests
      if (applicationIndicator) applicationIndicator.style.display = 'none';
      if (completeForm) completeForm.style.display = 'none';
      if (reviewButton) reviewButton.classList.add('d-none');
      if (repostButton) repostButton.classList.remove('d-none');

      updateApplicantButtons(card);
    } else {
      // For in-progress requests
      if (applicationIndicator) applicationIndicator.style.display = '';
      if (completeForm) completeForm.style.display = '';
      if (reviewButton) reviewButton.classList.add('d-none');
      if (repostButton) repostButton.classList.add('d-none');

      updateApplicantButtons(card);
    }
  });
}

function updateApplicantButtonsForCompleted(card) {
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
}

function updateApplicantButtons(card) {
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

// Listen for the custom event
document.addEventListener('requestCardsUpdated', function(e) {
  // Reinitialize any necessary functionality for the new content
  updateUIBasedOnStatus();
  initializeDropdowns();
  hideEmptyDropdowns();
});

function initializeDropdowns() {
  const dropdownButtons = document.querySelectorAll('.dropdown-btn_requests_index_my');
  dropdownButtons.forEach(button => {
    button.removeEventListener('click', handleDropdownClick);
    button.addEventListener('click', (event) => {
      event.preventDefault();
      event.stopPropagation();
      handleDropdownClick(button);
    });
  });
}
