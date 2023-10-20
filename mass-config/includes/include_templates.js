var spanVersion = document.getElementById("versionText");
var selectVersion = document.getElementById("selectVersion");
const deleteBtn = document.getElementById('deleteBtn');

function updateContent(selectedValue) {

    spanVersion.textContent = "Version FW : " + selectedValue;

    // Check if there are a new template save in a localStorage
    if (localStorage.getItem(localStorage.getItem("newtemplate") + "JSON") !== null && selectedValue.includes(localStorage.getItem("newtemplate"))) {
        const json = JSON.parse(localStorage.getItem(localStorage.getItem("newtemplate") + "JSON"));
        displayTable(json, true);
    } else {
        // var nameFile = `devices_config${selectedValue.substring(0, 3)}.json`;
        if (localStorage.getItem("currentTemplateName") !== null); {
            var nameFile = `devices_config_v${localStorage.getItem("currentTemplateName").substring(0, 3)}.json`;
            console.log(nameFile);
        }
        if (selectedValue !== undefined) {
            var nameFile = `devices_config_v${selectedValue.substring(0, 3)}.json`;
        }
        fetchJson(nameFile);
    }


}
function updateSpanVersion(selectedValue) {

    spanVersion.textContent = "Version FW : " + selectedValue;

}

selectVersion.addEventListener("change", function () {
    console.log("cc");
    var selectedValue = selectVersion.value;
    updateContent(selectedValue);
});


function defaultTemplate(event) {
    selectVersion.value.includes("Par défaut") ? deleteBtn.style.display = "none" : deleteBtn.style.display = "inline-block";

    event.target.value.includes("Par défaut") ? deleteBtn.style.display = "none" : deleteBtn.style.display = "inline-block";

    console.log("cc sdvsd" + event.target.value);
    updateContent(event.target.value)
}
function defaultTemplateLoad(selectval) {
    if (selectval.includes("Par défaut")) {
        deleteBtn.style.display = "none";
    } else {
        deleteBtn.style.display = "inline-block";
    }


}
// var initialSelectedValue = selectVersion.value;

var div = document.createElement('div');
div.innerHTML = localStorage.getItem('selectVersionTemplates');
var mySelect = div.querySelector('select');
updateSpanVersion(mySelect.value);
defaultTemplateLoad(mySelect.value)

if (localStorage.getItem('currentTemplateName')) {

    var currentTemplateName = localStorage.getItem('currentTemplateName').trim();
    console.log(currentTemplateName);
    if (localStorage.getItem(currentTemplateName + "JSON") === null) {
        console.log(localStorage.getItem('version'));
        const nameFile = `devices_config_v${localStorage.getItem('version').trim()}.json`;
        console.log(nameFile);
        fetchJson(nameFile);
    } else {

        // console.log(localStorage.getItem('currentTemplateName').split('-')[1].trim());

        var jsonTemplateName = `${localStorage.getItem('currentTemplateName').trim()}JSON`;
        var jsonTemplate = JSON.parse(localStorage.getItem(jsonTemplateName));
        // console.log(jsonTemplate);
        jsonTemplateName.includes('Par défaut') ?         
            displayTable(jsonTemplate, false):
            displayTable(jsonTemplate, true);
    }

}
else {

    console.log("dd" + storedVersion);
    const nameFile = `devices_config_v${storedVersion}.json`;
    fetchJson(nameFile);

}
