document.addEventListener('DOMContentLoaded', function() {
  initializeMyRequests();
  initializeDropdowns();
  console.log('DOMContentLoaded event fired');
});

function waitForContent() {
  return new Promise((resolve) => {
    const requestContainer = document.getElementById('requestContainer');
    
    if (isContentReady()) {
      resolve();
    } else {
      const observer = new MutationObserver((mutations, obs) => {
        if (isContentReady()) {
          obs.disconnect();
          resolve();
        }
      });
      
      observer.observe(requestContainer, {
        childList: true,
        subtree: true
      });
    }
  });
}

function isContentReady() {
  // Implement your check here. For example:
  const requestCards = document.querySelectorAll('.request-card_requests_index_my');
  return requestCards.length > 0;
}

function initializeMyRequests() {
  console.log('initializeMyRequests called');

  const requestContainer = document.getElementById('requestContainer');
  const searchInput = document.getElementById('searchInput');
  const cardBody = document.querySelector('.card-body');

  console.log('requestContainer:', requestContainer);
  console.log('searchInput:', searchInput);
  console.log('cardBody:', cardBody);

  // Search functionality
  if (searchInput) {
    searchInput.addEventListener('input', performSearch);
    console.log('Search input listener added');
  }

  // Use event delegation for dynamically loaded content
  if (requestContainer) {
    requestContainer.addEventListener('click', handleRequestContainerClick);
  }

  // Initialize tab functionality
  initializeTabs();

  // Call this function when the page loads
  // console.log('Calling updateUIBasedOnStatus');
  // updateUIBasedOnStatus();
  // console.log('Calling hideEmptyDropdowns');
  // hideEmptyDropdowns();

  waitForContent().then(() => {
    console.log('Content ready, updating UI');
    updateUIBasedOnStatus();
    hideEmptyDropdowns();
  });

  // Close dropdown when clicking outside
  document.addEventListener('click', handleOutsideClick);

  document.addEventListener('application:withdrawn', handleWithdrawal);

  hideWithdrawnApplications();

  console.log('initializeMyRequests completed');
}

//this is to search 
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

  // Update the content of the selected tab
  updateRequestCards(tabId);
}

function updateRequestCards(tabId) {
  console.log(`Updating request cards for tab: ${tabId}`);
  fetch(`/myrequests?tab=${tabId}`, {
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    }
  })
  .then(response => response.json())
  .then(data => {
    console.log(`Received data for ${tabId}:`, data);
    const tabPane = document.querySelector(`#${tabId}`);
    
    if (data[`${tabId}_requests_empty`]) {
      console.log(`Tab ${tabId} is empty, rendering empty state`);
      tabPane.innerHTML = data.empty_state_html;
    } else {
      console.log(`Tab ${tabId} has content, rendering regular HTML`);
      tabPane.innerHTML = data.html;
    }

    console.log(`Tab ${tabId} content after update:`, tabPane.innerHTML);

    // hideEmptyDropdowns();
    // initializeDropdowns();
    document.dispatchEvent(new CustomEvent('requestCardsUpdated', { detail: { tabId: tabId } }));
  })
  .catch(error => {
    console.error('Error updating request cards:', error);
  });
}

// tramsotion animations included without page reload, but buggy on the cloud 
// function handleCompleteForm(form) {
//   const requestCard = form.closest('.request-card_requests_index_my');
//   const applicationIndicator = requestCard.querySelector('.application-indicator_requests_index_my');
//   const reviewButton = requestCard.querySelector('.review-btn_mark_completed');
//   const repostButton = requestCard.querySelector('.repost-btn_unfulfilled');

//   // Update UI immediately
//   applicationIndicator.style.display = 'none';
//   form.style.display = 'none';

//   // Check if the request is unfulfilled
//   const isUnfulfilled = checkIfUnfulfilled(requestCard);

//   if (isUnfulfilled) {
//     repostButton.classList.remove('d-none');
//   } else {
//     reviewButton.classList.remove('d-none');
//   }

//   // Update request card status
//   requestCard.dataset.status = 'Completed';

//   // Update buttons for all applicants
//   updateApplicantButtonsForCompleted(requestCard);
//   const applicantPopups = requestCard.querySelectorAll('.popup_requests_index_my');
//   applicantPopups.forEach(popup => {
//     const chatButton = popup.querySelector('.custom-btn-chat_my');
//     const applicantInfo = popup.querySelector('.applicant-info_requests_index_my');
//     const splitButton = popup.querySelector('.split-button_requests_index_my');
//     const applicationStatus = splitButton.querySelector('.status-indicator_my')?.textContent.trim();

//     // Remove chat button
//     if (chatButton) chatButton.remove();

//     // Add review button if the applicant was accepted
//     if (applicationStatus === 'Accepted' && applicantInfo && !applicantInfo.querySelector('.leave-review-btn')) {
//       const reviewButton = document.createElement('button');
//       reviewButton.classList.add('btn', 'leave-review-btn');
//       reviewButton.textContent = 'Leave a Review';
//       // applicantInfo.appendChild(reviewButton);
//     }
//   });

//   // Update request card status
//   requestCard.dataset.status = 'Completed';

//   // Prepare for smooth transition
//   requestCard.style.transition = 'opacity 0.5s ease-out';
//   requestCard.style.opacity = '0';

//   setTimeout(() => {
//     // Move the card to the top of the Completed tab
//     const completedTabPane = document.querySelector('#completed');
//     const firstChild = completedTabPane.firstChild;
//     completedTabPane.insertBefore(requestCard, firstChild);

//     // Switch to the Completed tab
//     const completedTabButton = document.querySelector('[data-bs-target="#completed"]');
//     switchTab(completedTabButton);

//     // Fade the card back in
//     setTimeout(() => {
//       requestCard.style.opacity = '1';
//     }, 50);
//   }, 500);

//   fetch(form.action, {
//     method: form.method,
//     body: new FormData(form),
//     headers: {
//       'X-Requested-With': 'XMLHttpRequest',
//       'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
//     }
//   })
//   .then(response => response.json())
//   .then(data => {
//     if (!data.success) {
//       console.error(data.message);
//     }
//   })
//   .catch(error => {
//     console.error('Error:', error);
//   });
// }

// Simpler approach, refreshes page after user marks as complete, updates UI after reload
function handleCompleteForm(form) {
  fetch(form.action, {
    method: form.method,
    body: new FormData(form),
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    },
    redirect: 'follow' // Allow fetch to follow redirects
  })
  .then(response => {
    if (response.redirected) {
      // If the server sends a redirect, follow it
      window.location.href = response.url;
    } else {
      // If no redirect (which shouldn't happen based on your controller),
      // reload the page to ensure we're showing the latest state
      window.location.reload();
    }
  })
  .catch(error => {
    console.error('Error:', error);
    // Optionally, show an error message to the user
    alert('An error occurred while completing the request. Please try again.');
  });
}

function checkIfUnfulfilled(requestCard) {
  const status = requestCard.dataset.status;
  const requestDate = new Date(requestCard.dataset.date);
  const requestTime = requestCard.dataset.time;
  const [hours, minutes] = requestTime.split(':').map(Number);
  requestDate.setHours(hours, minutes);

  const now = new Date();

  
  return status !== 'Completed' && requestDate < now;
}

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
  if (!event.target.closest('.clickable-card_requests_index-wrapper_my') &&
      !event.target.closest('.accept-form') &&
      !event.target.closest('.reject-form')) {
    const openPopups = document.querySelectorAll('.popups-container_my.active');
    openPopups.forEach(closePopup);

    // Reset card body height
    const cardBody = document.querySelector('.card-body');
    if (cardBody) cardBody.style.height = 'auto';
  }
}

function hideEmptyDropdowns() {
  console.log('hideEmptyDropdowns called');
  document.querySelectorAll('.request-card_requests_index_my').forEach(card => {
    const applicantPopups = card.querySelectorAll('.popup_requests_index_my');
    const visibleApplicants = Array.from(applicantPopups).filter(popup => {
      // Check if the popup is visible and not withdrawn
      return popup.style.display !== 'none' && !popup.querySelector('.status-indicator_my.withdrawn');
    });
    const totalVisibleApplicants = visibleApplicants.length;
    const dropdownButton = card.querySelector('.dropdown-btn_requests_index_my');
    
    if (totalVisibleApplicants === 0 && dropdownButton) {
      dropdownButton.style.display = 'none';
    } else if (dropdownButton) {
      dropdownButton.style.display = 'block';
    }
  });
}


function handleAcceptRejectForm(form) {
  event.stopPropagation();
  const action = form.getAttribute('action');
  const method = form.getAttribute('method');
  const formData = new FormData(form);
  const buttonContainer = form.closest('.split-button_requests_index_my');

  fetch(action, {
    method: method,
    body: formData,
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    }
  })
  .then(response => {
    if (!response.ok) {
      return response.json().then(err => { throw err; });
    }
    return response.json();
  })
  .then(data => {
    if (data.redirect) {
    console.log(data)
      alert(data.notice);
      window.location.href = data.redirect;
    } else {
        if (data.status == 'Full'){
            alert('This request has already been fulfilled. Thank you.')
        }
        else{
          // Update UI only after successful response
          updateUI(buttonContainer, data.status);
          updateApplicantCountFromServer(buttonContainer, data.acceptedCount, data.numberOfPax);
        }
    }
  })
  .catch(error => {
    console.error('Error in handleAcceptRejectForm:', error);
    if (error.redirect) {
      alert(error.notice);
      window.location.href = error.redirect;
    } else {
      alert('An error occurred. Please try again.');
    }
  });
}

function updateUIBasedOnStatus() {
  console.log('updateUIBasedOnStatus called');
  document.querySelectorAll('.request-card_requests_index_my').forEach(card => {
    const applicationIndicator = card.querySelector('.application-indicator_requests_index_my');
    const completeForm = card.querySelector('.complete-form');
    const reviewButton = card.querySelector('.review-btn_mark_completed');
    const repostButton = card.querySelector('.repost-btn_unfulfilled');

    const currentTab = card.closest('.tab-pane').id;
    const requestStatus = card.dataset.status;

    if (requestStatus === 'Completed') {
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

function handleWithdrawal(event) {
  const requestId = event.detail.requestId;
  const requestCard = document.querySelector(`.request-card_requests_index_my[data-request-id="${requestId}"]`);
  if (requestCard) {
    const applicationCountElement = requestCard.querySelector('.application-count_requests_index_my');
    if (applicationCountElement) {
      let activeCount = parseInt(applicationCountElement.dataset.activeCount);
      activeCount--;
      applicationCountElement.dataset.activeCount = activeCount;
      applicationCountElement.textContent = `${activeCount} Applicant${activeCount !== 1 ? 's' : ''}`;
    }

    // Hide the withdrawn application's popup
    const withdrawnPopup = requestCard.querySelector(`.popup_requests_index_my[data-application-id="${event.detail.applicationId}"]`);
    if (withdrawnPopup) {
      withdrawnPopup.style.display = 'none';
    }

    hideEmptyDropdowns();
  }
}

function hideWithdrawnApplications() {
  document.querySelectorAll('.popup_requests_index_my').forEach(popup => {
    if (popup.querySelector('.status-indicator_my.withdrawn')) {
      popup.style.display = 'none';
    }
  });
}

function updateApplicantButtonsForCompleted(card) {
  const applicantPopups = card.querySelectorAll('.popup_requests_index_my');
  applicantPopups.forEach(popup => {
    const chatButton = popup.querySelector('.custom-btn-chat_my');
    const applicantInfo = popup.querySelector('.applicant-info_requests_index_my');
    const applicationStatus = popup.querySelector('.status-indicator_my')?.textContent.trim();

    // Remove chat button
    if (chatButton) chatButton.remove();

    // Add review button only if the application was accepted and the request is completed
    if (applicationStatus === 'Accepted' && card.dataset.status === 'Completed' && applicantInfo && !applicantInfo.querySelector('.leave-review-btn')) {
      const reviewButton = document.createElement('button');
      reviewButton.classList.add('btn', 'leave-review-btn');
      reviewButton.textContent = 'Leave a Review';
      // applicantInfo.appendChild(reviewButton);
    }
  });
}

function updateApplicantButtons(card) {
  const applicantPopups = card.querySelectorAll('.popup_requests_index_my');
  applicantPopups.forEach(popup => {
    const applicantInfo = popup.querySelector('.applicant-info_requests_index_my');
    let chatButton = popup.querySelector('.custom-btn-chat_my');
    const reviewButton = applicantInfo.querySelector('.leave-review-btn_mark_completed');

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
