document.addEventListener("DOMContentLoaded", () => {
    const tabs = document.querySelectorAll(".tab-link");
    const tabContents = document.querySelectorAll(".tab-content");
  
    tabs.forEach(tab => {
      tab.addEventListener("click", (e) => {
        e.preventDefault();
        const targetTab = e.target.getAttribute("data-tab");
  
        tabContents.forEach(content => {
          if (content.id === targetTab) {
            content.style.display = "block";
          } else {
            content.style.display = "none";
          }
        });
  
        tabs.forEach(tab => {
          if (tab.getAttribute("data-tab") === targetTab) {
            tab.classList.add("active");
          } else {
            tab.classList.remove("active");
          }
        });
      });
    });
  
    // Initialize to show the active charities tab by default
    const defaultTab = window.location.hash ? window.location.hash.substring(1) : 'active-tab';
    document.querySelector(`.tab-link[data-tab='${defaultTab}']`).click();
  });
  