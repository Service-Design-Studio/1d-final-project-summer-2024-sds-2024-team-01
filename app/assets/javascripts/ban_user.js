document.addEventListener("DOMContentLoaded", function() {
  initializeBanUser();
  initializeTabs();
  initializeSearch();
  
  // Show initial active tab content
  const activeTab = document.querySelector("#banUserTabs .nav-link.active");
  if (activeTab) {
    switchTab(activeTab);
  }
});

function initializeBanUser() {
  // Add any initialization logic for ban/unban if needed
}

function initializeTabs() {
  const tabButtons = document.querySelectorAll("#banUserTabs button");
  tabButtons.forEach((button) => {
    button.addEventListener("click", function(event) {
      event.preventDefault();
      switchTab(this);
    });
  });
}

function initializeSearch() {
  const searchInput = document.getElementById("searchInput");
  const searchForm = document.querySelector(".search-form_requests_index");

  searchForm.addEventListener("submit", function(event) {
    event.preventDefault();
    performSearch();
  });

  searchInput.addEventListener("input", function() {
    performSearch();
  });
}

function performSearch() {
  const searchTerm = document.getElementById("searchInput").value.toLowerCase().trim();
  const activeTabId = document.querySelector("#banUserTabs .nav-link.active").getAttribute("data-bs-target").replace("#", "");
  const userCards = document.querySelectorAll(`#${activeTabId} .user-card`);

  userCards.forEach(card => {
    const userName = card.querySelector(".user-name").textContent.toLowerCase();
    const userEmail = card.querySelector(".user-email").textContent.toLowerCase();

    if (userName.includes(searchTerm) || userEmail.includes(searchTerm)) {
      card.style.display = "block";
    } else {
      card.style.display = "none";
    }
  });
}

function switchTab(tabButton) {
  const tabId = tabButton.getAttribute("data-bs-target").replace("#", "");

  // Remove active class from all tabs
  const tabButtons = document.querySelectorAll("#banUserTabs button");
  tabButtons.forEach((btn) => {
    btn.classList.remove("active");
    btn.setAttribute("aria-selected", "false");
  });

  // Add active class to clicked tab
  tabButton.classList.add("active");
  tabButton.setAttribute("aria-selected", "true");

  // Hide all tab panes
  document.querySelectorAll(".tab-pane").forEach((pane) => {
    pane.classList.remove("show", "active");
  });

  // Show the selected tab pane
  const selectedPane = document.querySelector(
    tabButton.getAttribute("data-bs-target")
  );
  selectedPane.classList.add("show", "active");

  updateBanUserCards(tabId);
}

function updateBanUserCards(tabId) {
  fetch(`/admin/ban_user?tab=${tabId}`, {
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    }
  })
  .then(response => response.json())
  .then(data => {
    const tabPane = document.querySelector(`#${tabId}`);
    if (data.html) {
      tabPane.innerHTML = data.html;
    }
    
    if (!data.is_empty) {
      initializeBanUser();
    }

    document.dispatchEvent(new CustomEvent('banUserCardsUpdated', { detail: { tabId: tabId, isEmpty: data.is_empty } }));
    
    // Reapply search after updating cards
    performSearch();
  });
}

// Add any other necessary functions for ban/unban functionality