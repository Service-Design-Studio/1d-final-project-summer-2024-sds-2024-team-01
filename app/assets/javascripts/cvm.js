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
            }
            instance.input.dispatchEvent(new Event("change")); // Trigger change event for validation
        },
    });
});
