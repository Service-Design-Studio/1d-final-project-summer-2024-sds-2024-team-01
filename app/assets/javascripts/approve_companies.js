document.addEventListener("DOMContentLoaded", () => {
  const tabs = document.querySelectorAll(".tab-link");
  const tabContents = document.querySelectorAll(".tab-content");

  tabs.forEach(tab => {
    tab.addEventListener("click", (e) => {
      e.preventDefault();
      const targetTab = e.target.getAttribute("data-tab");

      // Show the corresponding tab content and hide others
      tabContents.forEach(content => {
        if (content.id === targetTab) {
          content.style.display = "block";
        } else {
          content.style.display = "none";
        }
      });

      // Update active tab class
      tabs.forEach(tab => {
        if (tab.getAttribute("data-tab") === targetTab) {
          tab.classList.add("active");
        } else {
          tab.classList.remove("active");
        }
      });

      // Update the URL hash without reloading the page
      history.pushState(null, null, `#${targetTab}`);
    });
  });

  // Initialize to show the active companies tab by default or based on URL hash
  const defaultTab = window.location.hash ? window.location.hash.substring(1) : 'active-tab';
  const defaultTabLink = document.querySelector(`.tab-link[data-tab='${defaultTab}']`);
  if (defaultTabLink) {
    defaultTabLink.click();
  } else {
    // Fallback to the first tab if the hash does not match any tab
    tabs[0].click();
  }
});
