const tabletbody = document.querySelector('table tbody');
const infosDiv = document.querySelector('.infos');

function updateInfos() {
  const visibleRowCount = Array.from(tabletbody.querySelectorAll('tr')).filter(row => row.style.display !== 'none').length;
  infosDiv.textContent = `Showing 1 to ${visibleRowCount} of ${visibleRowCount} ${visibleRowCount === 1 ? 'entry' : 'entries'}`;
}

updateInfos();
selectGroup.addEventListener('change', updateInfos);