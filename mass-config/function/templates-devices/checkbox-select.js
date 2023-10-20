function availableListTemplate(checkboxes = null) {
    // console.log("je rentre");
    const updateSelectTagVisibility = document.getElementById('updateSelectTagVisibility');
    const selectVersion = document.getElementById('selectVersion');
    // console.log(selectVersion);
    var div = document.createElement('div');
    div.innerHTML = localStorage.getItem('selectVersionTemplates');
    var versionConfig = div.querySelector('select');
    // console.log(versionConfig);
    const optgroups = versionConfig.querySelectorAll('optgroup');
    if (checkboxes == null){

        checkboxes = document.querySelectorAll('tr td input[type="checkbox"]');
    }
    var atLeastOneCheckboxIsSelected = false;
    var maxVersion = "";
    checkboxes.forEach(checkbox => {
        if (checkbox.checked) {
            atLeastOneCheckboxIsSelected = true;
            //console.log(checkbox + " true");
            const row = checkbox.closest('tr');
            //recover the n° version
            var version = row.cells[4].textContent.substring(2,5);
            // recover the max version
            version > maxVersion ? maxVersion = version : maxVersion = maxVersion;
            
            
        }
    });
    optgroups.forEach(optgroup => {
        //console.log(optgroup.label.substring(2,5));
        if (optgroup.label.substring(2,5) < maxVersion){
            optgroup.disabled = true;
        }else {optgroup.disabled = false;}
    })
    selectVersion.innerHTML = versionConfig.innerHTML
    // div.innerHTML = versionConfig.outerHTML;

    // selectVersion.outerHTML = div.innerHTML;
    if (atLeastOneCheckboxIsSelected){
        updateSelectTagVisibility.style.display = "inline-block";
    } else {
        updateSelectTagVisibility.style.display = "none";
        const rows = document.querySelectorAll('#tbodyListDevices tr');
        rows.forEach(row => {
            row.style.display = 'table-row';
          });
        selectGroup.value = 'tous'; 
    }
}
