function setPercentage(element, percentage) {
  const container = element.closest('.percentage-indicator-container');
  const circle = element.querySelector('.circle');
  const percentageText = element.querySelector('.percentage');
  const popup = container.querySelector('.percentage-popup .popup-content');
  
  // Calculate the circumference of the circle
  const radius = 15.9155; // This should match the value in the SVG path
  const circumference = radius * 2 * Math.PI;
  
  // Calculate the arc length
  const dashArray = (percentage / 100) * circumference;
  
  // Set the stroke dasharray
  circle.style.strokeDasharray = `${dashArray} ${circumference}`;
  
  // Set the text
  percentageText.textContent = `${percentage}%`;
  
  // Set the color based on the percentage
  let color, popupContent;
  if (percentage <= 33) {
    color = '#cc3232'; // red
    popupContent = 'Low suitability for this request, not recommended for you';
  } else if (percentage <= 75) {
    color = '#e7b416'; // yellow
    popupContent = 'Some suitability for this request, you may find this request suitable for you';
  } else {
    color = '#2dc937'; // green
    popupContent = 'This request suits you well. You should give it a shot!';
  }
  circle.style.stroke = color;
  popup.textContent = popupContent;
}

function updateIndicator(indicator) {
  const testValue = indicator.dataset.testValue;
  if (testValue !== null && testValue !== undefined) {
    setPercentage(indicator, parseInt(testValue));
  } else {
    const apiEndpoint = indicator.dataset.apiEndpoint;
    if (apiEndpoint) {
      fetch(apiEndpoint)
        .then(response => response.json())
        .then(data => {
          const percentage = data.percentage; // Adjust this based on your API response structure
          setPercentage(indicator, percentage);
        })
        .catch(error => console.error('Error fetching percentage data:', error));
    }
  }
}

// Find all percentage indicators and initialize them
document.querySelectorAll('.percentage-indicator').forEach(indicator => {
  updateIndicator(indicator);
  
  // Optionally, update the indicator periodically if it's using an API
  if (indicator.dataset.apiEndpoint) {
    setInterval(() => updateIndicator(indicator), 60000); // Update every minute
  }
});