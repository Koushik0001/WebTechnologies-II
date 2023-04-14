function enterDate(value) {
    const x = document.getElementById("optioanlDisplay");
    if(value == "now")
        x.style.display = 'none';
    else
        x.style.display = 'block';
}

function removeDate() {
    const y = document.getElementById("optioanlDisplay");
    y.style.display = 'block';
}