document.addEventListener('DOMContentLoaded', function() {
  const searchInput = document.getElementById('searchInput');
  const employeeTableBody = document.getElementById('employeeTableBody');

  searchInput.addEventListener('input', function() {
    const searchTerm = this.value.toLowerCase();
    const rows = employeeTableBody.getElementsByTagName('tr');

    for (let row of rows) {
      const name = row.querySelector('h6').textContent.toLowerCase();
      const email = row.cells[1].textContent.toLowerCase();

      if (name.includes(searchTerm) || email.includes(searchTerm)) {
        row.style.display = '';
      } else {
        row.style.display = 'none';
      }
    }
  });
});