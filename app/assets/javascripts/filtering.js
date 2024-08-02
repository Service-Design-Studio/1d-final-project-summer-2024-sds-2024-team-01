document.addEventListener('DOMContentLoaded', function() {
  initializeFilterDropdown();
  initializeSearch();
  initializeFilters();
});

function initializeFilterDropdown() {
  const filterBtn = document.querySelector('.filter-btn');
  const filterCollapse = document.getElementById('filterCollapse');
  const chevron = filterBtn.querySelector('.chevron-icon');

  filterBtn.addEventListener('click', (event) => {
      event.preventDefault();
      event.stopPropagation();
      
      if (filterCollapse.classList.contains('active')) {
          closeFilterDropdown(filterCollapse, chevron);
      } else {
          openFilterDropdown(filterCollapse, chevron);
      }
  });

  // Close dropdown when clicking outside
  document.addEventListener('click', (event) => {
      if (!event.target.closest('.filter-btn') && !event.target.closest('#filterCollapse')) {
          closeFilterDropdown(filterCollapse, chevron);
      }
  });
}

function openFilterDropdown(container, chevron) {
  container.classList.add('active');
  container.style.maxHeight = container.scrollHeight + 'px';
  chevron.classList.remove('fa-chevron-down');
  chevron.classList.add('fa-chevron-up');
}

function closeFilterDropdown(container, chevron) {
  container.classList.remove('active');
  container.style.maxHeight = null;
  chevron.classList.remove('fa-chevron-up');
  chevron.classList.add('fa-chevron-down');
}

function initializeSearch() {
  const searchForm = document.querySelector('.search-form_requests_index');
  searchForm.addEventListener('submit', function(e) {
      e.preventDefault();
      const searchTerm = document.getElementById('searchInput').value.toLowerCase();
      filterCards(searchTerm);
  });
}

function initializeFilters() {
  document.getElementById('durationFilter').addEventListener('change', applyFilters);
  document.getElementById('startDateFilter').addEventListener('change', applyFilters);
  document.getElementById('endDateFilter').addEventListener('change', applyFilters);
  document.getElementById('rewardFilter').addEventListener('change', applyFilters);
}

function applyFilters() {
  const duration = document.getElementById('durationFilter').value;
  const startDate = document.getElementById('startDateFilter').value;
  const endDate = document.getElementById('endDateFilter').value;
  const reward = document.getElementById('rewardFilter').value;

  const cards = document.querySelectorAll('.request-card_requests_index');
  
  cards.forEach(card => {
      const cardDuration = parseFloat(card.querySelector('.fas.fa-clock + span').textContent.trim().split(' ')[0]);
      const cardDate = new Date(card.querySelector('.fas.fa-calendar-alt + span').textContent.trim());
      const cardReward = card.querySelector('.reward-text_requests_index').textContent.trim();
      
      let showCard = true;
      
      // Apply filters
      if (duration) {
          const [min, max] = duration.split('-');
          if (max === '+') {
              showCard = showCard && cardDuration >= parseFloat(min);
          } else {
              showCard = showCard && cardDuration >= parseFloat(min) && cardDuration <= parseFloat(max);
          }
      }
      
      if (startDate && endDate) {
          const filterStartDate = new Date(startDate);
          const filterEndDate = new Date(endDate);
          showCard = showCard && cardDate >= filterStartDate && cardDate <= filterEndDate;
      }
      
      if (reward) {
          if (reward === 'with') {
              showCard = showCard && cardReward !== 'Reward: None';
          } else if (reward === 'without') {
              showCard = showCard && cardReward === 'Reward: None';
          }
      }
      
      card.style.display = showCard ? 'block' : 'none';
  });
}

function filterCards(searchTerm) {
  const cards = document.querySelectorAll('.request-card_requests_index');
  
  cards.forEach(card => {
      const title = card.querySelector('.card-title_requests_index').textContent.toLowerCase();
      const category = card.querySelector('.card-subtitle_requests_index').textContent.toLowerCase();
      
      if (title.includes(searchTerm) || category.includes(searchTerm)) {
          card.style.display = 'block';
      } else {
          card.style.display = 'none';
      }
  });
  
  // After searching, apply filters
  applyFilters();
}