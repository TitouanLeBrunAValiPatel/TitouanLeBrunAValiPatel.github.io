const versionText = document.getElementById('versionText');
var templateName = document.getElementById('templateName');
const newTemplate = document.getElementById('addNewTemplate');
const storedVersion = localStorage.getItem('version');
const errorMessage = document.getElementById('error-message');

if (localStorage.getItem('currentTemplateName')) {
    console.log(localStorage.getItem('currentTemplateName'));
    if(localStorage.getItem(localStorage.getItem('currentTemplateName').trim() + "JSON") === null){
        console.log(localStorage.getItem('version') + "eee");
        localStorage.setItem('AvailableToEdit', 'true');

        const nameFile = `devices_config_v${ localStorage.getItem('version').trim() }.json`;
        fetchJson(nameFile);
    }else{
        // console.log(localStorage.getItem('version') + "aaa");



        var jsonTemplateName = `${localStorage.getItem('currentTemplateName').trim()}JSON`;
        var jsonTemplate =  JSON.parse(localStorage.getItem(jsonTemplateName));
        console.log(jsonTemplate);
        displayTable(jsonTemplate, true);
    }
}
else {

    const nameFile = `devices_config_v${storedVersion}.json`;
    localStorage.setItem('AvailableToEdit', 'true');
    fetchJson(nameFile);

}

versionText.textContent += `${storedVersion}`;

newTemplate.addEventListener('click', function () {
    const regex = /^[a-zA-Z0-9\-_().{}[\]À-ÖÙ-Ýà-öù-ÿ\s]+$/;
    if (templateName.value == "") {
        errorMessage.textContent = 'Ce champ ne peut pas être vide';
        templateName.style.borderColor = 'red';

    }
    else if (templateName.value == "Par défaut") {
        errorMessage.textContent = 'Ce champ ne peut pas avoir pour nom "Par défaut"';
        templateName.style.borderColor = 'red';


    } else if (!regex.test(templateName.value)) {
        errorMessage.textContent = 'Ce champ contient des caractère(s) non autorisé(s)';
        templateName.style.borderColor = 'red';
    } else {

        localStorage.setItem('versionNewTemplate', storedVersion);
        localStorage.setItem('newtemplate', templateName.value);
        localStorage.setItem('newtemplateDone', "false");

        const cheminLocal = "templates_tab.html";
        window.location.href = cheminLocal;
        // selectConfig();

    }
});

// Load the JSON file corresponding to the version 
