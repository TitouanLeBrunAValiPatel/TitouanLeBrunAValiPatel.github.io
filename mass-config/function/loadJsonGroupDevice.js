// File to recover the data on templates_devices page
const table = document.querySelector('table');

const dataObject = {};

table.querySelectorAll('tr').forEach((row) => {
    const rowId = row.getAttribute('data-row-id');

    const rowData = {};

    row.querySelectorAll('td').forEach((cell, index) => {
        // Recover the contains tag
        const cellData = cell.textContent.trim();

        switch (index) {
            case 0:
                rowData.alertStatus = cellData;
                break;
            case 1:
                rowData.deviceIcon = cellData;
                break;
            case 2:
                rowData.deviceLink = cellData;
                break;
            case 3:
                rowData.redText = cellData;
                break;
            case 4:
                rowData.firmware = cellData;
                break;
            case 5:
                rowData.location = cellData;
                break;
            case 6:
                rowData.emptyData = cellData;
                break;
            case 7:
                rowData.checkbox = cell.querySelector('input').checked;
                break;
            case 8:
                const actions = [];
                cell.querySelectorAll('i').forEach((icon) => {
                    const title = icon.getAttribute('title');
                    actions.push(title);
                });
                rowData.actions = actions;
                break;
            default:
                break;
        }
    });

    dataObject[rowId] = rowData;
});

