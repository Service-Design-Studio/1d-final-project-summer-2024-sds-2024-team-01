document.addEventListener('DOMContentLoaded', function() {
  initializeBanUser();
  initializeTabs();
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
      // Prevent form button clicks from triggering card click
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
  // handle "Ban" button click
  if (event.target.closest('.ban-form')) {
    event.preventDefault();
    handleStatusChange(event.target.closest('.ban-form'), 'ban');
  }

  // handle cancel button
  if (event.target.closest('.cancel-form')) {
    event.preventDefault();
    handleStatusChange(event.target.closest('.cancel-form'), 'Active');
  }
}

function handleUnbanUserContainerClick(event) {
  if (event.target.closest('.unban-form')) {
    event.preventDefault();
    handleStatusChange(event.target.closest('.unban-form'), 'Active');
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
  const userId = userCard.dataset.userId;

  if (status === 'ban') {
    const unbanUserContainer = document.getElementById('unbanUserContainer');
    userCard.setAttribute('data-status', 'ban');
    unbanUserContainer.appendChild(userCard);
    switchTab(document.querySelector('[href="#unban"]'));
  } else if (status === 'Active') {
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
    } else if (userStatus === 'ban') {
      card.querySelector('.ban-form').style.display = 'none';
      card.querySelector('.cancel-form').style.display = 'none';
      card.querySelector('.unban-form').style.display = 'block';
    }
  });
}
