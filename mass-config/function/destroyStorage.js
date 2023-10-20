function destroyLocalstorageTemplate() {

    // Delete localStorage variables
    localStorage.getItem('selectVersionTemplates');

    const selectVersionTemplates = localStorage.getItem('selectVersionTemplates');
    // La chaîne de caractères HTML représentant un élément <select>

    // Créez un nouvel élément <div> pour contenir la chaîne HTML
    const divContainer = document.createElement('div');
    // Utilisez innerHTML pour attribuer la chaîne HTML à ce div
    divContainer.innerHTML = selectVersionTemplates;
    const nouveauSelect = divContainer.querySelector('select');
    for (var i = 0; i < nouveauSelect.options.length; i++) {
        // Vérifiez si la valeur de l'option correspond à celle que vous souhaitez supprimer
        if (nouveauSelect.options[i].value === `${localStorage.getItem('currentTemplateName')}`) {
            // Supprimez l'option correspondante
            nouveauSelect.remove(i);
        }
    }
    console.log(nouveauSelect.outerHTML);
    localStorage.setItem('selectVersionTemplates', nouveauSelect.outerHTML);

    localStorage.removeItem('versionNewTemplate');
    localStorage.removeItem('versionText');
    localStorage.removeItem(`${localStorage.getItem('currentTemplateName').split('-')[1].trim()}JSON`)
    localStorage.removeItem('newtemplate');
    localStorage.removeItem('templateName');
    localStorage.removeItem('addNewTemplate');
    localStorage.removeItem('version');


    // Avant la redirection, définissez une valeur dans le stockage local pour indiquer que la pop-up doit être affichée
    localStorage.setItem("showPopup", "true");
    console.log(localStorage.getItem('showPopup'));
    // Redirigez la page
    window.location.href = "templates_tab.html";
    // Reload the page

}