var selectVersion = document.getElementById('selectVersion');
var mySelect;
function selectConfig() {
    if (localStorage.getItem('selectVersionTemplates') === null) {

        var select = `<select onchange="defaultTemplate()">
            <optgroup label="FW4.4">
                <option value="4.4 - Par défaut">Par défaut</option>
            </optgroup>
            <optgroup label="FW4.5">
                <option value="4.5 - Par défaut">Par défaut</option>
            </optgroup>
            <optgroup label="FW4.6">
                <option value="4.6 - Par défaut">Par défaut</option>
                <option value="4.6 - template1">template1</option>
                <option value="4.6 - template2">template2</option>
            </optgroup>
            <optgroup label="FW4.7">
                <option value="4.7 - Leapseconds10">Leapseconds10</option>
                <option value="4.7 - Par défaut">Par défaut</option>
                <option value="4.7 - V2X">V2X</option>
                </optgroup>
                </select>`;
        localStorage.setItem('selectVersionTemplates', select);
        // selectVersion.insertAdjacentHTML("afterbegin", select);
    } else {

        var div = document.createElement('div');
        div.innerHTML = localStorage.getItem('selectVersionTemplates');
        mySelect = div.querySelector('select');
        // console.log(localStorage.getItem('selectVersionTemplates'));
        // console.log(selectVersion);
    }
    if (localStorage.getItem('newtemplateDone') == "false" && localStorage.getItem('newtemplate') !== null && localStorage.getItem('selectVersionTemplates') !== null) {
        // console.log(localStorage.getItem('newtemplate'));
        // console.log(localStorage.getItem('versionNewTemplate'));

        var div = document.createElement('div');
        div.innerHTML = localStorage.getItem('selectVersionTemplates');
        mySelect = div.querySelector('select');

        const newTemplate = localStorage.getItem('newtemplate');
        const versionNewTemplate = localStorage.getItem('versionNewTemplate');

        const selectOption = document.createElement('option');
        selectOption.value = `${versionNewTemplate} - ${newTemplate}`;
        selectOption.textContent = newTemplate;

        // selected the good optgroup correspond to the versionNewTemplate
        let targetOptgroup;
        switch (versionNewTemplate) {
            case '4.4':
                targetOptgroup = mySelect.querySelector('optgroup[label="FW4.4"]');
                break;
            case '4.5':
                targetOptgroup = mySelect.querySelector('optgroup[label="FW4.5"]');
                break;
            case '4.6':
                targetOptgroup = mySelect.querySelector('optgroup[label="FW4.6"]');
                break;
            case '4.7':
                targetOptgroup = mySelect.querySelector('optgroup[label="FW4.7"]');
                break;
            default:
                break;
        }

        if (targetOptgroup) {
            targetOptgroup.appendChild(selectOption);
        }
        localStorage.setItem('newtemplateDone', "true");

        localStorage.setItem('selectVersionTemplates', mySelect.outerHTML);
    }

    // var selectVersionn = document.getElementById('selectVersion');
    // selectVersionn.insertAdjacentHTML("afterbegin", mySelect.innerHTML);
}


function currentSelectTemplate() {

    if (localStorage.getItem('currentTemplateName')) {
        console.log("selectVersion");
        if (localStorage.getItem('selectVersionTemplates') !== null) {
            var div = document.createElement('div');
            div.innerHTML = localStorage.getItem('selectVersionTemplates');
            var mySelect = div.querySelector('select');
            // console.log(mySelect);
            for (var i = 0; i < mySelect.options.length; i++) {
                if (mySelect.options[i].value === localStorage.getItem('currentTemplateName')) {
                    mySelect.options[i].setAttribute('selected', 'true');
                    // defaultTemplateLoad(mySelect.options[i].value);

                } else {
                    mySelect.options[i].removeAttribute('selected');
                }
            }
            
            localStorage.setItem('selectVersionTemplates', div.innerHTML);
            var selectVersionn = document.getElementById('selectVersion');
            selectVersionn.insertAdjacentHTML("afterbegin", div.innerHTML);
            
            if (location.href.includes("templates.html")){
                
                
                selectVersionn.style.display = 'none';
                var divElement = selectVersionn.closest('div');
                var inputElement = document.createElement("input");
                
                // Définissez le type de l'élément input
                inputElement.setAttribute("type", "text");
                inputElement.disabled = true;
                inputElement.value = selectVersionn.value;
                divElement.appendChild(inputElement);
                
            }
            
            // selectVersionn
            // console.log(localStorage.getItem('selectVersionTemplates'));
            // for (let index = 0; index < mySelect.options.length; index++) {
            //     const element = mySelect.options[index];
            //     console.log(element.value + "===" + localStorage.getItem('currentTemplateName'));

            //     // selectVersion.style.display = "none" ;
            //     if (element.value === localStorage.getItem('currentTemplateName')) {
            //         // element.selected = true; // Définir la propriété selected de l'option à true
            //         mySelect.selectedIndex = index;                // localStorage.setItem('selectVersionTemplates', mySelect.outerHTML);

            //         // var divElement = mySelect.closest('div');
            //         // var inputElement = document.createElement("input");

            //         // Définissez le type de l'élément input
            //         // inputElement.setAttribute("type", "text");
            //         // inputElement.disabled = true;
            //         // inputElement.value = element.value;
            //         // divElement.outerHTML = inputElement;
            //         // divElement.innerText = "";
            //         // divElement.appendChild(inputElement);
            //     }

            // }
        }
    }
}
selectConfig();
currentSelectTemplate();
// localStorage.setItem('selectVersionTemplates', selectVersion.outerHTML);
