document.addEventListener("DOMContentLoaded", function() {
  initializeCharities();
  initializeTabs();
  handleClickableRows();
  initializeSearch();

  // Show initial active tab content
  const activeTab = document.querySelector("#charitiesTabs .nav-link.active");
  if (activeTab) {
    switchTab(activeTab);
  }
});

function initializeCharities() {
  // Add any initialization logic for charities if needed
}

function initializeTabs() {
  const tabButtons = document.querySelectorAll("#charitiesTabs button");
  tabButtons.forEach((button) => {
    button.addEventListener("click", function(event) {
      event.preventDefault();
      switchTab(this);
    });
  });
}

function switchTab(tabButton) {
  const tabId = tabButton.getAttribute("data-bs-target").replace("#", "");

  // Remove active class from all tabs
  const tabButtons = document.querySelectorAll("#charitiesTabs button");
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

  updateCharityCards(tabId);
}

function updateCharityCards(tabId) {
  fetch(`/admin/charities?tab=${tabId}`, {
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
      initializeCharities();
      handleClickableRows();
    }

    document.dispatchEvent(new CustomEvent('charityCardsUpdated', { detail: { tabId: tabId, isEmpty: data.is_empty } }));
  });
}

function handleClickableRows() {
  document.querySelectorAll('.clickable-row').forEach(row => {
    row.addEventListener('click', function() {
      window.location = this.dataset.link;
    });
  });
}

function initializeSearch() {
  const searchInput = document.getElementById('searchInput');

  // Add an event listener for input events on the search input
  searchInput.addEventListener('input', function() {
    // Get the search query and convert it to lowercase
    const query = searchInput.value.toLowerCase();

    // Get the currently active tab pane
    const activeTabPane = document.querySelector('.charities-tab-pane.show.active');

    // Get all table rows in the active tab
    const rows = activeTabPane.querySelectorAll('tbody tr');

    // Loop through each row and check if it matches the search query
    rows.forEach(row => {
      const charityNameCell = row.querySelector('td:nth-child(1)'); // Assuming charity name is in the first column

      // Check if the charity name includes the search query
      if (charityNameCell.textContent.toLowerCase().includes(query)) {
        row.style.display = ''; // Show the row
      } else {
        row.style.display = 'none'; // Hide the row
      }
    });
  });
}
