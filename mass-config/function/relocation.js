function redirectionLocale() {
    if (localStorage.getItem('currentTemplateName') !== null) {
        localStorage.setItem('version', localStorage.getItem('currentTemplateName').substring(0, 3));

    } else {


        var selectVersion = document.getElementById("selectVersion");
        localStorage.setItem('version', selectVersion.value.substring(0, 3));
    }

    var cheminLocal = "new_template.html";
    window.location.href = cheminLocal;
}

function relocationTemplatesTabToTemplatesDevices(event) {
    var tagA = event.target.closest('a');
    const row = tagA.closest('tr');
    const version = row.getElementsByTagName('td')[0].textContent;
    const templateName = row.getElementsByTagName('td')[1].textContent;
    localStorage.setItem('currentTemplateName', version + "-" + templateName);
    localStorage.setItem('version', version);
    console.log('cc'+ localStorage.getItem('currentTemplateName'));
    // if (localStorage.getItem('selectVersionTemplates')) {
    //     var div = document.createElement('div');
    //     div.innerHTML = localStorage.getItem('selectVersionTemplates');
    //     var mySelect = div.querySelector('select');
    //     // Parcourir toutes les options de l'élément <select>
    //     for (var i = 0; i < mySelect.options.length; i++) {
    //         var option = mySelect.options[i];

    //         // Vérifier si la valeur de l'option correspond à la valeur que vous souhaitez sélectionner
    //         if (option.value === localStorage.getItem('currentTemplateName')) {
    //             // Définir la propriété "selected" de cette option à true
    //             option.selected = true;
    //             console.log(option);
    //             console.log("je rentre");
                
    //             // break;  // Sortir de la boucle une fois que vous avez trouvé l'option
    //         }else{
    //             option.selected = false;
    //         }
    //     }
    //     console.log(mySelect.innerHTML);
    //     localStorage.setItem('selectVersionTemplates', mySelect.outerHTML);
    //     // location.reload();
    //     console.log( localStorage.getItem('selectVersionTemplates'));
    // }
    // // console.log(localStorage.getItem('currentTemplateName'));

}

document.getElementById("monBouton").addEventListener("click", redirectionLocale);