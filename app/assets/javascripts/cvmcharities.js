document.addEventListener("DOMContentLoaded", function() {
    const addedCharitiesList = document.getElementById("added-charities");
    const availableCharitiesList = document.getElementById("available-charities");
    const searchInput = document.getElementById("searchInput");

    function addClickListeners() {
        document.querySelectorAll("#added-charities li, #available-charities li")
            .forEach(function(item) {
                item.addEventListener("click", function() {
                    var targetList = item.parentElement.id === "added-charities"
                        ? availableCharitiesList
                        : addedCharitiesList;
                    targetList.appendChild(item);
                });
            });
    }

    function filterCharities(searchTerm) {
        const items = availableCharitiesList.querySelectorAll("li");
        items.forEach(function(item) {
            const text = item.textContent.toLowerCase();
            if (text.includes(searchTerm.toLowerCase())) {
                item.style.display = "";
            } else {
                item.style.display = "none";
            }
        });
    }

    addClickListeners();

    searchInput.addEventListener("input", function() {
        filterCharities(this.value);
    });

    document.getElementById("charity-form")
        .addEventListener("submit", function(event) {
            event.preventDefault();
            var selectedCharityIds = [];
            addedCharitiesList.querySelectorAll("li").forEach(function(item) {
                selectedCharityIds.push(item.dataset.id);
            });
            document.getElementById("charity-ids").value = selectedCharityIds.join(",");
            console.log(selectedCharityIds.join(','));
            this.submit();
        });
});