document.addEventListener("DOMContentLoaded", function() {
    document
        .querySelectorAll("#added-charities li, #available-charities li")
        .forEach(function(item) {
            item.addEventListener("click", function() {
                var parent = item.parentElement;
                var targetList =
                    parent.id === "added-charities"
                        ? "available-charities"
                        : "added-charities";
                document.getElementById(targetList).appendChild(item);
            });
        });

    document
        .getElementById("charity-form")
        .addEventListener("submit", function() {
            event.preventDefault()
            var selectedCharityIds = [];
            document.querySelectorAll("#added-charities li").forEach(function(item) {
                selectedCharityIds.push(item.dataset.id);
            });
            document.getElementById("charity-ids").value =
                selectedCharityIds.join(",");
            console.log(selectedCharityIds.join(','))

            this.submit()

        });

});
