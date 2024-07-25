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

  // Update UI when the page loads
  updateUIBasedOnStatus();
}

function handleBanUserContainerClick(event) {
  if (event.target.closest('.ban-form')) {
    event.preventDefault();
    handleStatusChange(event.target.closest('.ban-form'), 'ban');
  }

  if (event.target.closest('.cancel-form')) {
    event.preventDefault();
    handleStatusChange(event.target.closest('.cancel-form'), 'normal');
  }

  if (event.target.closest('.more-btn')) {
    event.preventDefault();
    const moreButton = event.target.closest('.more-btn');
    const userId = moreButton.dataset.userId;
    window.location.href = `/users/${userId}`;
  }
}

function handleUnbanUserContainerClick(event) {
  if (event.target.closest('.unban-form')) {
    event.preventDefault();
    handleStatusChange(event.target.closest('.unban-form'), 'normal');
  }

  if (event.target.closest('.more-btn')) {
    event.preventDefault();
    const moreButton = event.target.closest('.more-btn');
    const userId = moreButton.dataset.userId;
    window.location.href = `/users/${userId}`;
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
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      updateUserStatus(form.closest('.user-card'), status);
    } else {
      alert('Failed to update user status.');
    }
  })
  .catch(error => {
    console.error('Error:', error);
  });
}

function updateUserStatus(userCard, status) {
  if (status === 'ban') {
    // Move the user card to the Unban tab
    const unbanUserContainer = document.getElementById('unbanUserContainer');
    userCard.setAttribute('data-status', 'ban');
    unbanUserContainer.appendChild(userCard);
    // Switch to the Unban tab
    switchTab(document.querySelector('#unban-tab'));
  } else if (status === 'normal') {
    // Remove the user card from the current view
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

  // Remove active class from all tabs
  const tabButtons = document.querySelectorAll('#banUserTab a');
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
    } else if (userStatus === 'ban') {
      card.querySelector('.ban-form').style.display = 'none';
      card.querySelector('.cancel-form').style.display = 'none';
      card.querySelector('.unban-form').style.display = 'block';
    }
  });
}
