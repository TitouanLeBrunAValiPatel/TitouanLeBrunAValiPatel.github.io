// Load the JSON file
fetch('misc/list-devices.json')
    .then(response => response.json())
    .then(data => {
        
        loadedData(data)

    })
    .catch(error => {
        console.error('Erreur lors du chargement du fichier JSON :', error);
    });
function loadedData(data) {

    var dataRow = '';
        for (const key in data) {
            if (data.hasOwnProperty(key)) {
                const rowData = data[key];
                dataRow += `<tr data-row-id="${key}">
                <td class="text-left" style="width:7px;"><span class="${rowData.alertStatus}"></span>
                </td>
                <td class="text-left" style="width:70px;"><span class="device-table-icon"><img src="${rowData.deviceIcon}" title="yogoko"></span></td>
                <td class="text-left"><span><a class="list-device-down" href="#">${rowData.deviceLink}</a><br></span>
                </td>
                <td class="text-left"><span class="red">${rowData.redText}</span></td>
                <td class="text-left">${rowData.firmware}</td>
                <td class="text-left">${rowData.location}</td>
                <td class="text-left">${rowData.emptyData}</td>
                <td class="text-left"><input type="checkbox" name="" id="" onChange="availableListTemplate()" class="custom-checkbox" ></td>

                <td class="text-left" style="width:90px;">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-1"><a href="#"> <i class="fa fa-id-card fa-lg icon-theme" title="${rowData.actions[0]}"></i></a></div>
                            <div class="col-xs-1"><a href="#"> <i class="fa fa-exclamation-circle fa-lg icon-theme" title="${rowData.actions[1]}"></i></a></div>
                            <div class="col-xs-1"><a href="#"> <i class="fa fa-pencil fa-lg icon-theme" title="${rowData.actions[2]}"></i></a></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-1"><a href="#" target="ssh"><i class="fa fa-lock fa-lg icon-theme" title="${rowData.actions[3]}"></i></a></div>
                        </div>
                    </div>
                </td>
            </tr>`;




            }

        }
        const tbody = document.getElementById('tbodyListDevices');

        tbody.innerHTML =  dataRow

       groupDevice(tbody.querySelectorAll('tr'));
       updateInfos();

       const checkboxes = document.querySelectorAll('tr td input[type="checkbox"]');
        availableListTemplate(checkboxes);
}
