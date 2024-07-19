document.addEventListener("DOMContentLoaded", function() {
    // Call this function when the page loads
    initMyApplications();
    initializeTabs();
    handleDropdowns();
    // You might also want to call this function after any AJAX updates
    // that might change the status of requests
});
function initMyApplications() {
    const searchInput = document.getElementById("searchInput");
    const requestCards = document.querySelectorAll(
        ".request-card_requests_index_my",
    );

    searchInput.addEventListener("input", function() {
        const searchTerm = searchInput.value.toLowerCase().trim();
        console.log("Search term:", searchTerm); // Debug log

        requestCards.forEach((card) => {
            const titleElement = card.querySelector(".card-title_requests_index_my");
            const title = titleElement ? titleElement.innerText.toLowerCase() : "";
            console.log("Card title:", title); // Debug log

            if (title.includes(searchTerm)) {
                card.style.display = "block"; // Show the card
            } else {
                card.style.display = "none"; // Hide the card
            }
        });
    });

    // Dropdown functionality
}
function handleDropdowns(){
    const dropdownButtons = document.querySelectorAll(
        ".dropdown-btn_requests_index_my",
    );
    const cardBody = document.querySelector(".card-body");

    dropdownButtons.forEach((button) => {
        button.addEventListener("click", (event) => {
            event.preventDefault();
            event.stopPropagation();
            const wrapper = button.closest(
                ".clickable-card_requests_index-wrapper_my",
            );
            const popupsContainer = wrapper.querySelector(".popups-container_my");

            // Close all other open popups
            document
                .querySelectorAll(".popups-container_my.active")
                .forEach((container) => {
                    if (container !== popupsContainer) {
                        closePopup(container);
                    }
                });

            if (popupsContainer.classList.contains("active")) {
                closePopup(popupsContainer);
            } else {
                openPopup(popupsContainer);
            }

            // Adjust card body height
            setTimeout(() => {
                cardBody.style.height = cardBody.scrollHeight + "px";
            }, 10);
        });
    });

    function openPopup(container) {
        container.classList.add("active");
        container.style.maxHeight = container.scrollHeight + "px";
        const button = container
            .closest(".clickable-card_requests_index-wrapper_my")
            .querySelector(".dropdown-btn_requests_index_my");
        button.innerHTML = '<i class="fas fa-chevron-up"></i>';
        container.closest(
            ".clickable-card_requests_index-wrapper_my",
        ).style.marginBottom = container.scrollHeight + "px";
    }

    function closePopup(container) {
        container.classList.remove("active");
        container.style.maxHeight = null;
        const button = container
            .closest(".clickable-card_requests_index-wrapper_my")
            .querySelector(".dropdown-btn_requests_index_my");
        button.innerHTML = '<i class="fas fa-chevron-down"></i>';
        container.closest(
            ".clickable-card_requests_index-wrapper_my",
        ).style.marginBottom = null;
    }

    // Close dropdown when clicking outside
    document.addEventListener("click", (event) => {
        if (!event.target.closest(".clickable-card_requests_index-wrapper_my")) {
            const openPopups = document.querySelectorAll(
                ".popups-container_my.active",
            );
            openPopups.forEach(closePopup);

            // Reset card body height
            cardBody.style.height = "auto";
        }
    });
}
function updateUIBasedOnStatus() {
    document
        .querySelectorAll(".request-card_requests_index_my")
        .forEach((card) => {
            const requestStatus = card.dataset.requestStatus;
            const applicationStatusElement = card.querySelector(
                ".application-status_indicator_my",
            );
            const applicationStatus =
                applicationStatusElement.dataset.applicationStatus;
            const chatButton = card.querySelector(".custom-btn-chat_my");
            const withdrawButton = card.querySelector(
                ".withdraw-btn_requests_index_my",
            );
            const reviewButton = card.querySelector(".leave-review-btn");

            if (requestStatus === "Completed" && applicationStatus === "Accepted") {
                // Change status to 'Concluded'
                applicationStatusElement.textContent = "Concluded";
                applicationStatusElement.classList.remove("accepted");
                applicationStatusElement.classList.add("concluded");

                // Hide chat button
                if (chatButton) chatButton.style.display = "none";

                // Hide withdraw button and show review button
                if (withdrawButton) withdrawButton.style.display = "none";
                if (reviewButton) reviewButton.style.display = "block";
            }
        });
}

function initializeTabs() {
    const tabButtons = document.querySelectorAll("#myApplicationsTabs button");
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
    const tabButtons = document.querySelectorAll("#myApplicationsTabs button");
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
        tabButton.getAttribute("data-bs-target"),
    );
    selectedPane.classList.add("show", "active");

    updateApplicationCards(tabId);
}

function updateApplicationCards(tabId) {
    fetch(`/myapplications?tab=${tabId}`, {
        headers: {
            "X-Requested-With": "XMLHttpRequest",
            Accept: "application/json",
        },
    })
        .then((response) => response.json())
        .then((data) => {
            const tabPane = document.querySelector(`#${tabId}`);
            tabPane.innerHTML = data.html;
            // Dispatch a custom event after content is loaded
            document.dispatchEvent(
                new CustomEvent("requestCardsUpdated", { detail: { tabId: tabId } }),
            );
        });
}
// Listen for the custom event
document.addEventListener("requestCardsUpdated", function(e) {
    // Reinitialize any necessary functionality for the new content
    initMyApplications();
    updateUIBasedOnStatus();
    handleDropdowns();
    initializeDropdowns();
});

function initializeDropdowns() {
    const dropdownButtons = document.querySelectorAll(
        ".dropdown-btn_requests_index_my",
    );
    dropdownButtons.forEach((button) => {
        button.removeEventListener("click", handleDropdownClick);
        button.addEventListener("click", (event) => {
            event.preventDefault();
            event.stopPropagation();
            handleDropdownClick(button);
        });
    });
}
