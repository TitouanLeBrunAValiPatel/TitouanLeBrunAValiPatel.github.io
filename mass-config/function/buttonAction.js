
$("#tbodyVariables").on('click', '[class*="blocActions"] a', function () {
    var idAction = $(this).attr("id");
    if (idAction.includes("edit")) {
        editAction(idAction);
    }
    else if (idAction.includes("suppr")) {
        supprAction(idAction);
    }
    else if (idAction.includes("submit")) {
        submitAction(idAction);
    }
});

function editAction(idAction) {
    //select which field
    var idAction = idAction.replace("edit-", "");
    var fieldAction = $("[name ='" + idAction + "']");
    //field style for complete
    $("[id='submit-" + idAction + "']").parent(".blocActionsSubmit").css("display", "inline-block");
    $("[id='submit-" + idAction + "" + "']").parent(".blocActionsSubmit").css("display", "inline-block");
    valFieldAction = fieldAction.val();
    //Dynamic style when field is in "edit" mode.
    fieldAction
        .css({ "pointer-events": "auto", "border": "2px inset #EBE9ED" })
        .focus()
        .closest('tr').addClass("overloadValue");

    if (fieldAction.is('input[type=number]') || fieldAction.is('select')) {
        //Display arrows for select choice and for changing integer value (increase or decrease).
        fieldAction.css({ "-webkit-appearance": "auto", "-moz-appearance": "auto" });
    }

    fieldAction.focusout(function () {
        submitAction(idAction);
    });
}

function submitAction(idAction) {
    //select which field
    var idAction = idAction.replace("submit-", "");
    var fieldAction = $("[name ='" + idAction + "']");

    fieldAction.css({ "pointer-events": "none", "border": "none" });
    $("[id='submit-" + idAction + "']").parent(".blocActionsSubmit").css("display", "none");

    //Removing dropdown arrows.
    if (fieldAction.is('select')) {
        fieldAction.css({ "-webkit-appearance": "none", "-moz-appearance": "none" });
    }
    else if (fieldAction.is('input[type=number]')) {
        fieldAction.css({ "-webkit-appearance": "none", "-moz-appearance": "textfield" });
    }
}

//By default, the previous versions are disabled.
function disabledDowngrade() {
    $("#configFormHeader option").each(function (index, option) {
        //If the selected version is higher than the option value : disabled.
        if (this.value < $("#configFormHeader select").val()) {
            $(this).attr("disabled", 'disabled');
        } else {
            $(this).attr("disabled", false);
        }
    });
}

//The user wants to downgrade. Show the warning modal.
$("#configFormHeader").on('click', '#btnDowngrade', function () {
    $("#downgradeWarning").modal("show");
});
$("#configFormHeader").on('click', '#btnUpdateConfiguration', function () {
    // Sélectionnez l'élément dans lequel vous souhaitez effectuer le remplacement
    var selectElement = document.getElementById("selectVersion");
    var selectedValue = selectElement.value;
    var templateTextElement = document.getElementById("updateConfigurationLabel");
    var checkboxes = document.querySelectorAll('.custom-checkbox');

    // liste des appareils selectionner
    var devicesList = "";
    checkboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            var row = checkbox.closest('tr');
            devicesList += row.cells[2].textContent;
            devicesList += "<br>";
        }
    });

    templateTextElement.innerHTML = templateTextElement.innerHTML.replace("[nom du template]", selectedValue);
    templateTextElement.innerHTML = templateTextElement.innerHTML.replace("[Liste des appareils selectionnés]", devicesList);


    $("#updateConfiguration").modal("show");
});


//The user confirms to downgrade. Access to previous versions.
function confirmDowngrade() {
    $("#downgradeWarning").modal("hide");
    $("#configFormHeader optgroup").each(function (index, optgroup) {
        $(this).attr("disabled", false);
    });
}



