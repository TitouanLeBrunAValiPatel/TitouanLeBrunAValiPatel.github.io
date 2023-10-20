    const selectAllCheckbox = document.querySelector('#selectAllCheckbox');

    selectAllCheckbox.addEventListener('click', function () {
        const checkboxes = document.querySelectorAll('.custom-checkbox');
        // Check all the checkboxes visible
        checkboxes.forEach(function (checkbox) {
            const trElement = checkbox.closest('tr');
            if (trElement.style.display !== "none"){

                checkbox.checked = selectAllCheckbox.checked;

            }

        });
        availableListTemplate();
    });


    function changeValue() {
    var selectElement = document.getElementById("selectVersion");
    var selectedOption = selectElement.options[selectElement.selectedIndex];
    selectVersion.addEventListener("change", function () {
        selectedOption.textContent = selectElement.value;
    });
}


function editLines() {
    $("#updateConfiguration").modal("hide");
    var selectElement = document.getElementById("selectVersion");
    var checkboxes = document.querySelectorAll('.custom-checkbox');

    checkboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            var row = checkbox.closest('tr');
            row.cells[4].textContent = "FW" + selectElement.value;
            checkbox.checked = false;
        }
    });
    removeFilter();
    availableListTemplate();
    afficherPopup("Modification des templates réussi !", "ff");
}


