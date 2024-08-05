document.addEventListener('DOMContentLoaded', function() {
  initializeBanUser();
  initializeTabs();
});

function initializeBanUser() {
  document.querySelectorAll('.user-card').forEach(card => {
    card.addEventListener('click', function(event) {
      if (event.target.tagName.toLowerCase() !== 'button' && event.target.tagName.toLowerCase() !== 'form') {
        const userId = card.dataset.userId;
        window.location.href = `/profile/${userId}`;
      }
    });
  });

  document.querySelectorAll('.ban-form, .unban-form, .cancel-form').forEach(form => {
    form.addEventListener('submit', function(event) {
      event.preventDefault();
      const status = form.classList.contains('ban-form') ? 'ban' : form.classList.contains('unban-form') ? 'Active' : 'Active';
      handleStatusChange(form, status);
    });
  });

  updateUIBasedOnStatus();
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
    console.log('Server response:', data); // Add this line to log the response
    if (data.success) {
      updateUserStatus(form.closest('.user-card'), status);
      alert('Status updated successfully.');
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
    userCard.remove(); // Remove the user card from both tabs
  }

  updateUIBasedOnStatus();
  reattachEventListeners(); // Re-attach event listeners to newly moved elements
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

function reattachEventListeners() {
  document.querySelectorAll('.user-card').forEach(card => {
    card.removeEventListener('click', handleCardClick);
    card.addEventListener('click', handleCardClick);
  });

  document.querySelectorAll('.ban-form, .unban-form, .cancel-form').forEach(form => {
    form.removeEventListener('submit', handleFormSubmit);
    form.addEventListener('submit', handleFormSubmit);
  });
}

function handleCardClick(event) {
  if (event.target.tagName.toLowerCase() !== 'button' && event.target.tagName.toLowerCase() !== 'form') {
    const userId = this.dataset.userId;
    window.location.href = `/profile/${userId}`;
  }
}

function handleFormSubmit(event) {
  event.preventDefault();
  const status = this.classList.contains('ban-form') ? 'ban' : 'Active';
  handleStatusChange(this, status);
}
