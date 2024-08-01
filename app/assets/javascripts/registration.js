function firsttosecond() {
  event.preventDefault();
  document.getElementById("step-1").style.translate = "-300%";
  document.getElementById("step-2").style.translate = "0%";
}

function secondtothird() {
  document.getElementById("step-2").style.translate = "-300%";
  document.getElementById("step-3").style.translate = "0%";
}

function thirdtosecond() {
  document.getElementById("step-3").style.translate = "300%";
  document.getElementById("step-2").style.translate = "0%";
}

function secondtofirst() {
  document.getElementById("step-2").style.translate = "300%";
  document.getElementById("step-1").style.translate = "0%";
}
