function groupDevice(rows) {
  
  // Save the groups devices in a localStorage
  const groupDevices = [...new Set([...rows].map(row => row.cells[5].textContent))];
  localStorage.setItem('groupDevices', JSON.stringify(groupDevices));
  
  // Fill the select tag by the group devices
  const selectGroup = document.getElementById('selectGroup');
  const groups = JSON.parse(localStorage.getItem('groupDevices'));
  var optionGroup = `<option value="tous" disabled selected>Filtrer par groupe</option>`
  optionGroup += groups.map(group => `
    <option value="${group}">${group}</option>
  `).join('');
  
  selectGroup.innerHTML = optionGroup;
}

// function to filter the devices visible compared with the selected group
function updateRowVisibility(selectedGroup) {
  const rows = document.querySelectorAll('#tbodyListDevices tr')
  rows.forEach(row => {
    const cells = row.cells;
    const cellule = cells[7];
    const checkbox = cellule.querySelector('input[type="checkbox"]');

    if (selectedGroup === 'tous' || selectedGroup === cells[5].textContent) {
      row.style.display = 'table-row';
    } else {
      row.style.display = 'none';
      checkbox.checked = false;
    }
  });
  if (selectedGroup === 'tous') {
    selectGroup.value = 'tous';
  }
}
console.log(selectAllCheckbox);

selectGroup.addEventListener('change', function () {
  updateRowVisibility(this.value);
});

function removeFilter() {

  const rows = document.querySelectorAll('#tbodyListDevices tr');
  let atLeastOneCheckboxChecked = false;
  selectAllCheckbox.checked = false

  // Check if a checkbox is checked
  rows.forEach(row => {
    const cellule = row.cells[7];
    const checkbox = cellule.querySelector('input[type="checkbox"]');
    if (checkbox && checkbox.checked) {
      atLeastOneCheckboxChecked = true;
      return;
    }
  });
  // Display all the devices
  if (atLeastOneCheckboxChecked) {

    rows.forEach(row => {
      row.style.display = 'table-row';
      const cellule = row.cells[7];
      const checkbox = cellule.querySelector('input[type="checkbox"]');
      if (checkbox) {

        checkbox.checked = false;
      }
    });
  }
}


