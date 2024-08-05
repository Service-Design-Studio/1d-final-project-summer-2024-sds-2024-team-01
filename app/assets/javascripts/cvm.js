function clipboard() {
    code = document.getElementById("companycode");
    navigator.clipboard.writeText(code.innerHTML.trim());
}

document.addEventListener("DOMContentLoaded", function() {
    flatpickr("#reportdate", {
        mode: "range",
        dateFormat: "Y-m-d",
        allowInput: false,
        onClose: function(selectedDates, dateStr, instance) {
            if (!dateStr) {
                instance.input.value = ""; // Clear the input if no valid date was selected
            } else {
                // Split the dateStr to get the start and end dates
                const dates = dateStr.split(" to ");
                if (dates.length === 2) {
                    const startDate = dates[0];
                    const endDate = dates[1];

                    // Create hidden input fields for start_date and end_date
                    const startDateInput = document.createElement("input");
                    startDateInput.type = "hidden";
                    startDateInput.name = "start_date";
                    startDateInput.value = startDate;

                    const endDateInput = document.createElement("input");
                    endDateInput.type = "hidden";
                    endDateInput.name = "end_date";
                    endDateInput.value = endDate;

                    // Append the hidden fields to the form
                    const form = instance.input.closest('form');
                    form.appendChild(startDateInput);
                    form.appendChild(endDateInput);
                }
            }
            instance.input.dispatchEvent(new Event("change")); // Trigger change event for validation
        },
    });
});
