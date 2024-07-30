document.addEventListener('DOMContentLoaded', function() {
  initializeBanUser();
});

function initializeBanUser() {
  const banUserContainer = document.getElementById('banUserContainer');
  const unbanUserContainer = document.getElementById('unbanUserContainer');

  // Initialize tab functionality
  initializeTabs();

  // Event delegation for dynamically loaded content
  if (banUserContainer) {
    banUserContainer.addEventListener('click', handleBanUserContainerClick);
  }
  if (unbanUserContainer) {
    unbanUserContainer.addEventListener('click', handleUnbanUserContainerClick);
  }

  // Event listener for card click
  document.querySelectorAll('.user-card').forEach(card => {
    card.addEventListener('click', function(event) {
      if (event.target.tagName.toLowerCase() !== 'button' && event.target.tagName.toLowerCase() !== 'form') {
        const userId = card.dataset.userId;
        window.location.href = `/profile/${userId}`;
      }
    });
  });

  // Update UI when the page loads
  updateUIBasedOnStatus();
}

function handleBanUserContainerClick(event) {
  if (event.target.closest('.ban-form')) {
    event.preventDefault();
    handleStatusChange(event.target.closest('.ban-form'), 'banned');
  }

  if (event.target.closest('.cancel-form')) {
    event.preventDefault();
    handleStatusChange(event.target.closest('.cancel-form'), 'normal');
  }
}

function handleUnbanUserContainerClick(event) {
  if (event.target.closest('.unban-form')) {
    event.preventDefault();
    handleStatusChange(event.target.closest('.unban-form'), 'normal');
  }
}

function handleStatusChange(form, status) {
  fetch(form.action, {
    method: form.method,
    body: new FormData(form),
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    }
  })
  .then(response => {
    if (!response.ok) throw new Error('Network response was not ok');
    return response.json();
  })
  .then(data => {
    if (data.success) {
      updateUserStatus(form.closest('.user-card'), status);
      displayNotification(data.message);
    } else {
      displayNotification(data.message, true);
    }
  })
  .catch(error => {
    console.error('Error:', error);
    displayNotification('An error occurred while updating user status.', true);
  });
}

function displayNotification(message, isError = false) {
  const notificationArea = document.getElementById('notification-area');
  notificationArea.textContent = message;
  notificationArea.style.color = isError ? 'red' : 'green';
  setTimeout(() => notificationArea.textContent = '', 3000);
}

function updateUserStatus(userCard, status) {
  const unbanUserContainer = document.getElementById('unbanUserContainer');
  if (status === 'banned' && unbanUserContainer) {
    userCard.setAttribute('data-status', 'banned');
    unbanUserContainer.appendChild(userCard);
    switchTab(document.querySelector('[href="#unban"]'));
  } else if (status === 'normal') {
    userCard.remove();
  }
  updateUIBasedOnStatus();
}

function initializeTabs() {
  const tabButtons = document.querySelectorAll('#banUserTab a');
  tabButtons.forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault();
      switchTab(this);
    });
  });
}

function switchTab(tabButton) {
  const tabId = tabButton.getAttribute('href').replace('#', '');

  const tabButtons = document.querySelectorAll('#banUserTab a');
  tabButtons.forEach(btn => {
    btn.classList.remove('active');
    btn.setAttribute('aria-selected', 'false');
  });

  tabButton.classList.add('active');
  tabButton.setAttribute('aria-selected', 'true');

  document.querySelectorAll('.tab-pane').forEach(pane => {
    pane.classList.remove('show', 'active');
  });

  const selectedPane = document.querySelector(tabButton.getAttribute('href'));
  selectedPane.classList.add('show', 'active');
}

function updateUIBasedOnStatus() {
  document.querySelectorAll('.user-card').forEach(card => {
    const userStatus = card.getAttribute('data-status');

    if (userStatus === 'under_review') {
      card.querySelector('.ban-form').style.display = 'block';
      card.querySelector('.cancel-form').style.display = 'block';
      card.querySelector('.unban-form').style.display = 'none';
    } else if (userStatus === 'banned') {
      card.querySelector('.ban-form').style.display = 'none';
      card.querySelector('.cancel-form').style.display = 'none';
      card.querySelector('.unban-form').style.display = 'block';
    }
  });
}
