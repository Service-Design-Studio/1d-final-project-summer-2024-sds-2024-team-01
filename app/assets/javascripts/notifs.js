function togglenotifs() {
    console.log(document.getElementById("notificationpopup").style.display)
    if (document.getElementById("notificationpopup").style.display == "block") {
        console.log("close!");
        document.getElementById("notificationpopup").style.display = "none";
    } else {
        document.getElementById("notificationpopup").style.display = "block";
        console.log("open!");
    }
}
