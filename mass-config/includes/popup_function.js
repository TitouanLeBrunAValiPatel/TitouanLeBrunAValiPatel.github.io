function afficherPopup(message, type) {
    const popup = document.getElementById('popup');
    const popupText = document.getElementById('popup-text');
  
    popupText.textContent = message;
    popup.classList.add(type);
    popup.classList.add('fade-in'); // Ajoutez la classe pour l'animation
    popup.style.display = 'block';
  
    setTimeout(() => {
      popup.classList.remove(type);
    //   popup.classList.remove('fade-in'); // Retirez la classe après l'animation
      popup.style.display = 'none';
    }, 3000); // La pop-up disparaîtra après 3 secondes (3000 millisecondes)
  }
window.onload = function() {
console.log(localStorage.getItem('showPopup'));

if (localStorage.getItem("showPopup") === "true") {
    console.log(localStorage.getItem('showPopup'));

    afficherPopup("Suppression du template Réussi !", "ff");
    // Après avoir affiché la pop-up, réinitialisez la valeur dans le stockage local
    localStorage.setItem("showPopup", "false");
}
console.log(localStorage.getItem('showPopup'));

};