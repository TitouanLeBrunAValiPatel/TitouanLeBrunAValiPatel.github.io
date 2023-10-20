
// on click "save" button in the new template page
newTemplate.addEventListener('click', updateTemplates);

//     const jsonData = {};
    
//     const tbody = document.getElementById('tbodyVariables');
    
//     const rows = tbody.getElementsByTagName('tr');

//     let currentGroup = null;
//     let currentVariable = null;
//     let rowspanCount = 0;

//     for (const row of rows) {
//         const cells = row.getElementsByTagName('td');

//         if (cells.length >= 2) {
//             // If there are more than 4 cell it means there are a new group
//             if (cells.length >= 4) {
//                 var group = cells[0].textContent.trim();
//                 jsonData[group] = jsonData[group] || {};
//             }
            
//             // If the cell is the group or the variable
//             if (cells[0].hasAttribute('rowspan')) {
//                 rowspanCount = parseInt(cells[0].getAttribute('rowspan'));
//                 currentGroup = group;
//                 jsonData[currentGroup] = jsonData[currentGroup] || {};
//                 jsonData[currentGroup][cells[1].textContent.trim()] = jsonData[currentGroup][cells[1].textContent.trim()] || {};

                
//                 var value = typeTD(cells[2]);

//                 jsonData[currentGroup][cells[1].textContent.trim()] = {
//                     type: value[0], 
//                     regex: value[1], 
//                     description: "test", 
//                     defaultValue: value[2] 
//                 };
//             } else {
//                 jsonData[currentGroup][cells[0].textContent.trim()] = jsonData[currentGroup][cells[0].textContent.trim()] || {};
                
//                 var value = typeTD(cells[1]);

//                 jsonData[currentGroup][cells[0].textContent.trim()] = {
//                     type: value[0],
//                     regex: value[1],
//                     description: "test",
//                     defaultValue: value[2]
//                 };
//             }
//         }
//     }

//     // Convertir JSON to string
//     const jsonString = JSON.stringify(jsonData, null, 2);

//     // console.log(jsonString);

//     // Save the json with the name of the template plus "JSON" in localSotrage
//     localStorage.setItem(templateName.value + "JSON", jsonString);
// });

// Functon to determinate the type, regex and the default value
function typeTD(tdcell) {
    var selectElement = tdcell.querySelector('select');
    if (selectElement) {

        const selectedOption = selectElement.options[selectElement.selectedIndex];
        const selectedValue = selectedOption.value;
        return ["boolean", "/^(true|false)$/", selectedValue];
    }

    var inputElement = tdcell.querySelector('input');
    if (inputElement) {

        const inputType = inputElement.type;

        if (inputType === "number") {
            return ["integer", "/^\\d+$/", inputElement.value];
        } else if (inputType === "text") {
            return ["string", "", inputElement.value];
        } else {
            return ["string", "", inputElement.value];
        }
    }

    return ["string", "", ""];
}
function updateTemplates() {
    console.log("cc");
    const jsonData = {};
    
    const tbody = document.getElementById('tbodyVariables');
    
    const rows = tbody.getElementsByTagName('tr');

    let currentGroup = null;
    let currentVariable = null;
    let rowspanCount = 0;

    for (const row of rows) {
        const cells = row.getElementsByTagName('td');

        if (cells.length >= 2) {
            // If there are more than 4 cell it means there are a new group
            if (cells.length >= 4) {
                var group = cells[0].textContent.trim();
                jsonData[group] = jsonData[group] || {};
            }
            
            // If the cell is the group or the variable
            if (cells[0].hasAttribute('rowspan')) {
                rowspanCount = parseInt(cells[0].getAttribute('rowspan'));
                currentGroup = group;
                jsonData[currentGroup] = jsonData[currentGroup] || {};
                jsonData[currentGroup][cells[1].textContent.trim()] = jsonData[currentGroup][cells[1].textContent.trim()] || {};

                
                var value = typeTD(cells[2]);

                jsonData[currentGroup][cells[1].textContent.trim()] = {
                    type: value[0], 
                    regex: value[1], 
                    description: "test", 
                    defaultValue: value[2] 
                };
            } else {
                jsonData[currentGroup][cells[0].textContent.trim()] = jsonData[currentGroup][cells[0].textContent.trim()] || {};
                
                var value = typeTD(cells[1]);

                jsonData[currentGroup][cells[0].textContent.trim()] = {
                    type: value[0],
                    regex: value[1],
                    description: "test",
                    defaultValue: value[2]
                };
            }
        }
    }

    // Convertir JSON to string
    const jsonString = JSON.stringify(jsonData, null, 2);
    // console.log(jsonString);

    if (location.href.includes('new_template.html')){

        localStorage.setItem(localStorage.getItem('version').trim() + ' - ' + templateName.value.trim() + "JSON", jsonString);
    }else {
        console.log(selectVersion);
        var template = selectVersion.value.trim();
        localStorage.setItem(template + "JSON", jsonString);
        location.reload();
    }
    // Save the json with the name of the templat v
}