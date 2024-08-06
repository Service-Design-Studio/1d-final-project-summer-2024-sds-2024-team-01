document.addEventListener("DOMContentLoaded", function() {
  initializeCompanies();
  initializeTabs();
  handleClickableRows();
  initializeSearch();
  
  // Show initial active tab content
  const activeTab = document.querySelector("#companiesTabs .nav-link.active");
  if (activeTab) {
    switchTab(activeTab);
  }
});

function initializeCompanies() {
  // Add any initialization logic for companies if needed
}

function initializeTabs() {
  const tabButtons = document.querySelectorAll("#companiesTabs button");
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
  const tabButtons = document.querySelectorAll("#companiesTabs button");
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

  updateCompanyCards(tabId);
}

function updateCompanyCards(tabId) {
  fetch(`/admin/approve_companies?tab=${tabId}`, {
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
      initializeCompanies();
      handleClickableRows();
    }

    document.dispatchEvent(new CustomEvent('companyCardsUpdated', { detail: { tabId: tabId, isEmpty: data.is_empty } }));
    
    // Reapply search after updating cards
    const searchInput = document.getElementById('searchInput');
    if (searchInput.value) {
      const event = new Event('input');
      searchInput.dispatchEvent(event);
    }
  });
}

function handleClickableRows() {
  document.querySelectorAll('.clickable-row').forEach(row => {
    row.addEventListener('click', function(e) {
      if (!e.target.closest('button')) {
        window.location = this.dataset.link;
      }
    });
  });
}

function initializeSearch() {
  const searchInput = document.getElementById('searchInput');

  searchInput.addEventListener('input', function() {
    const query = searchInput.value.toLowerCase();
    const activeTabPane = document.querySelector('.tab-pane.show.active');
    
    if (!activeTabPane) {
      console.error('No active tab pane found');
      return;
    }

    const rows = activeTabPane.querySelectorAll('.row.py-2.border-bottom.clickable-row');
    
    if (rows.length === 0) {
      console.error('No rows found in the active tab pane');
      return;
    }

    rows.forEach(row => {
      const nameCell = row.querySelector('.col-3:first-child');
      const managerCell = row.querySelector('.col-3:nth-child(3)');

      if (!nameCell || !managerCell) {
        console.error('Required cells not found in row', row);
        return;
      }

      if (nameCell.textContent.toLowerCase().includes(query) || 
          managerCell.textContent.toLowerCase().includes(query)) {
        row.style.display = '';
      } else {
        row.style.display = 'none';
      }
    });
  });
}