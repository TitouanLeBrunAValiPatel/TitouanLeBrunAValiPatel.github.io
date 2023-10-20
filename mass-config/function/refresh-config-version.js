


// load data for templates and new_templates file
function fetchJson(fileJSON) {
    // console.log(fileJSON);
    fetch(` misc/${fileJSON}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur de chargement du fichier JSON.');
            }
            return response.json();
        })
        .then(data => {

            console.log(data);
            if (localStorage.getItem('currentTemplateName').includes('Par défaut')) {
                console.log(localStorage.getItem('AvailableToEdit'));
                if (localStorage.getItem('AvailableToEdit') == 'true'){

                    displayTable(data, true);
                    localStorage.setItem('AvailableToEdit', 'false');
                } else {
                    displayTable(data, false);
                }
            } else {
                displayTable(data, true);
            }
             
        })
        .catch(error => {
            console.error('Erreur :', error);
        });
}


function displayTable(dataVersion, admin) {
    let allVariables = "";
    // console.log(dataVersion);
    document.getElementById('thActions').textContent = admin ? "Actions" : "Action";
    for (const groupVar in dataVersion) {
        const variable = dataVersion[groupVar];
        let changeGroup = true;

        for (const variableName in variable) {
            const value = variable[variableName];
            const groupTitle = changeGroup
                ? `<td rowspan=${Object.keys(variable).length} class="table-bordered overloadValue">${groupVar}</td>`
                : '';
            var classTr = "";
            location.href.includes('new_template') ? classTr = "text-center  overloadValue" :  classTr = "text-center";
            allVariables += `<tr class='${classTr}'>
                            ${groupTitle}
                            <td><label for='${variableName}' >${variableName}</label></td>
                            <td>`;

            if (value.type.toLowerCase() === 'boolean') {
                allVariables += `<select name='${groupVar}.${variableName}'>
                                  <option value='true'${value.defaultValue === "true" ? " selected" : ""}>true</option>
                                  <option value='false'${value.defaultValue === "false" ? " selected" : ""}>false</option>
                                 </select>`;
            } else if (value.type.toLowerCase() === 'integer') {
                allVariables += `<input type='number' id='${variableName}' name='${groupVar}.${variableName}' value='${value.defaultValue}'/>`;
            } else if (value.type.toLowerCase() === 'string') {
                allVariables += `<input type='text' id='${variableName}' name='${groupVar}.${variableName}' value='${value.defaultValue}'/>`;
            } else {
                allVariables += "<p>Erreur de typage de la variable.</p>";
            }

            allVariables += `<div class='blocActionsSubmit'>
                             <a class='glyphicon glyphicon-ok btn btn-success btn-xs' id='submit-${groupVar}.${variableName}' title ='Cliquer pour confirmer la valeur.'></a>
                        </div>
                    </td>`;

            if (admin) {
                allVariables += `<td>
                                <div class='blocActions'>
                                    <a class='btn btn-success btn-xs' id='edit-${groupVar}.${variableName}' " title='Cliquer pour modifier la valeur.'>
                                        <span class='fa fa-pencil fa-lg' style='vertical-align: middle;'></span>
                                    </a>
                                    <a class='btn btn-primary btn-xs' data-toggle='tooltip' data-placement='top' title='${value.description}'>
                                       <span class='fa fa-question-circle-o fa-lg' style='vertical-align: middle;'></span>
                                    </a>
                                </div>
                            </td>`;
            } else {
                allVariables += `<td>
                                <div class='blocActions'>
                                    <a class='btn btn-primary btn-xs' data-toggle='tooltip' data-placement='top' title='${value.description}'>
                                       <span class='fa fa-question-circle-o fa-lg' style='vertical-align: middle;'></span>
                                    </a>
                                </div>
                            </td>`;
            }

            allVariables += "</tr>";
            changeGroup = false;

        }
    }

    const tbody = document.getElementById('tbodyVariables');
    tbody.innerHTML = allVariables;
}

function templateList() {
    
    const tableTemplates = document.getElementById('tbodyTemplates');
    var tableVersion = "";
    if (localStorage.getItem('selectVersionTemplates') !== null);
    {
        const selectVersionTemplates = localStorage.getItem('selectVersionTemplates');
        // La chaîne de caractères HTML représentant un élément <select>
        // Créez un nouvel élément <div> pour contenir la chaîne HTML
        const divContainer = document.createElement('div');
        // Utilisez innerHTML pour attribuer la chaîne HTML à ce div
        divContainer.innerHTML = selectVersionTemplates;
    
        // Maintenant, divContainer contient un élément <select> en tant qu'enfant
        // Vous pouvez accéder à cet élément comme suit
        const nouveauSelect = divContainer.querySelector('select');
    
        // Vous pouvez maintenant ajouter cet élément à votre page ou faire d'autres opérations avec lui
        console.log(nouveauSelect.options);
        for (let index = 0; index < nouveauSelect.options.length; index++) {
    
    
            const element = nouveauSelect.options[index];
            var version = element.value.split('-')[0];
            var templateName = element.value.split('-')[1];
            // console.log(templateName);
            tableVersion += `
                <tr data-row-id="${index}"> 
                <td class="">${version}</td>
                <td class="">${templateName}</td>
                <td class="">${getRandomInt(1, 10)}</td>
                <td class="">J'écris une note pour le template  </td>
                
                <td>
                <div class='blocActions'>
                <a href="./templates.html" onclick="relocationTemplatesTabToTemplatesDevices(event)" class='btn btn-success btn-xs'
                title='Cliquer pour modifier le template.'>
                <span class='fa fa-pencil fa-lg'
                style='vertical-align: middle;'></span>
                </a>
                </div>
                </td>
                </tr>`;
    
        }
    
    
        tableTemplates.outerHTML = tableVersion;
    }
}

templateList();
// selectVersion.addEventListener('change', templateList);


// Génère un nombre entier aléatoire entre min (inclus) et max (exclus)
function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min)) + min;
}