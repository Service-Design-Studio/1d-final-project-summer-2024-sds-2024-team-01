function togglenotifs() {
    if (document.getElementById("notificationpopup").style.display == "block") {
        document.getElementById("notificationpopup").style.display = "none";
    } else {
        document.getElementById("notificationpopup").style.display = "block";
    }
}

document.addEventListener("DOMContentLoaded", () => {
    const notificationpopup = document.getElementById("notificationpopup");
    const showNotificationsButton = document.getElementById("shownotifs");
    const showNotificationsIcon = document.getElementById("shownotifsicon");

    document.addEventListener("click", function(event) {
        if (
            !notificationpopup.contains(event.target) &&
            event.target != showNotificationsButton &&
            event.target != showNotificationsIcon
        ) {
            notificationpopup.style.display = "none"; // Hide the popup
        }
    });

    showNotificationsButton.addEventListener("click",togglenotifs);
    showNotificationsIcon.addEventListener("click",togglenotifs);
});

function removeallnotifs(event) {
    event.preventDefault(); // Prevent the default form submission

    const form = event.target.closest("form");
    const formData = new FormData(form);

    fetch(form.action, {
        method: "POST", // or form.method if you want to dynamically get the method
        headers: {
            Accept: "application/json",
        },
        body: formData,
    })
        .then((response) => {
            if (response.ok) {
                const notifElements = document.querySelectorAll(".notifcolumn");
                notifElements.forEach((notif) => {
                    notif.remove();
                });
                document.getElementById("nonotifs").style.display = "block";
            }
        })
        .catch((error) => console.error("Error:", error));
}
function removenotif(event, index) {
    event.preventDefault(); // Prevent the default form submission

    const form = event.target.closest("form");
    const formData = new FormData(form);

    fetch(form.action, {
        method: "POST", // or form.method if you want to dynamically get the method
        headers: {
            Accept: "application/json",
        },
        body: formData,
    })
        .then((response) => {
            if (response.ok) {
                // Remove the notification element from the DOM
                const notifElement = document.getElementById(`notif-${index}`);
                if (notifElement) {
                    notifElement.remove();
                }
                if (document.querySelectorAll(".notifcolumn.d-flex").length == 0) {
                    document.getElementById("nonotifs").style.display = "block";
                }
            } else {
                console.error("Failed to mark notification as read");
            }
        })
        .catch((error) => console.error("Error:", error));
}
