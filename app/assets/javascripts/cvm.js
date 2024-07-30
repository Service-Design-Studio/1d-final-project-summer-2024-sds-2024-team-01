function clipboard(){
    code = document.getElementById("companycode")
    navigator.clipboard.writeText(code.innerHTML);
}
