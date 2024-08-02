document.addEventListener('DOMContentLoaded', function() {
    initializeFilterDropdown();
    initializeSearch();
    initializeFilters();
    initializeTimePickers();
    initializeDatePickers();
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

    // document.addEventListener('click', (event) => {
    //     if (!event.target.closest('.filter-btn') && !event.target.closest('#filterCollapse')) {
    //         closeFilterDropdown(filterCollapse, chevron);
    //     }
    // });
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
    document.getElementById('rewardFilter').addEventListener('change', applyFilters);
    document.getElementById('categoryFilter').addEventListener('change', applyFilters);
}

function initializeTimePickers() {
    const startTimePicker = document.getElementById('startTimeFilter');
    const endTimePicker = document.getElementById('endTimeFilter');

    populateTimePicker(startTimePicker);
    populateTimePicker(endTimePicker);

    startTimePicker.addEventListener('change', function() {
        validateAndUpdateEndTime(startTimePicker, endTimePicker);
        applyFilters();
    });

    endTimePicker.addEventListener('change', function() {
        validateAndUpdateStartTime(startTimePicker, endTimePicker);
        applyFilters();
    });
}

function populateTimePicker(picker) {
    for (let i = 0; i < 24; i++) {
        const option = document.createElement('option');
        let hour = i % 12 === 0 ? 12 : i % 12;
        let period = i < 12 ? 'AM' : 'PM';
        option.value = i.toString().padStart(2, '0') + ':00';
        option.text = hour + ':00 ' + period;
        picker.appendChild(option);
    }
}

function validateAndUpdateEndTime(startPicker, endPicker) {
    const startTime = parseInt(startPicker.value.split(':')[0]);
    const endTime = parseInt(endPicker.value.split(':')[0]);

    if (endTime <= startTime) {
        endPicker.value = ((startTime + 1) % 24).toString().padStart(2, '0') + ':00';
    }
}

function validateAndUpdateStartTime(startPicker, endPicker) {
    const startTime = parseInt(startPicker.value.split(':')[0]);
    const endTime = parseInt(endPicker.value.split(':')[0]);

    if (startTime >= endTime) {
        startPicker.value = ((endTime - 1 + 24) % 24).toString().padStart(2, '0') + ':00';
    }
}

function initializeDatePickers() {
    const startDatePicker = document.getElementById('startDateFilter');
    const endDatePicker = document.getElementById('endDateFilter');

    const today = new Date().toISOString().split('T')[0];
    startDatePicker.min = today;
    endDatePicker.min = today;

    startDatePicker.addEventListener('change', function() {
        validateAndUpdateEndDate(startDatePicker, endDatePicker);
        applyFilters();
    });

    endDatePicker.addEventListener('change', applyFilters);
}

function validateAndUpdateEndDate(startPicker, endPicker) {
    if (endPicker.value < startPicker.value) {
        endPicker.value = startPicker.value;
    }
    endPicker.min = startPicker.value;
}

function convertTimeToMinutes(time) {
    const [hours, minutes] = time.split(':');
    return parseInt(hours) * 60 + parseInt(minutes);
}

function applyFilters() {
    const duration = document.getElementById('durationFilter').value;
    const startDate = document.getElementById('startDateFilter').value;
    const endDate = document.getElementById('endDateFilter').value;
    const startTime = document.getElementById('startTimeFilter').value;
    const endTime = document.getElementById('endTimeFilter').value;
    const reward = document.getElementById('rewardFilter').value;
    const category = document.getElementById('categoryFilter').value;

    const cards = document.querySelectorAll('.request-card_requests_index');
    
    cards.forEach(card => {
        const cardDuration = parseFloat(card.querySelector('.fas.fa-clock + span').textContent.trim().split(' ')[0]);
        const cardDateTimeText = card.querySelector('.fas.fa-calendar-alt + span').textContent.trim();
        const [cardDateText, cardTimeText] = cardDateTimeText.split(',');
        const cardDate = new Date(cardDateText);
        const cardTime = cardTimeText.trim();
        const cardReward = card.querySelector('.reward-text_requests_index').textContent.trim();
        const cardCategory = card.querySelector('.card-subtitle_requests_index').textContent.trim();
        
        let showCard = true;
        
        // Duration filter
        if (duration) {
            const [min, max] = duration.split('-');
            if (max === '+') {
                showCard = showCard && cardDuration >= parseFloat(min);
            } else {
                showCard = showCard && cardDuration >= parseFloat(min) && cardDuration <= parseFloat(max);
            }
        }
        
        // Date range filter
        if (startDate && endDate) {
            const filterStartDate = new Date(startDate);
            const filterEndDate = new Date(endDate);
            showCard = showCard && cardDate >= filterStartDate && cardDate <= filterEndDate;
        }
        
        // Time range filter
        if (startTime && endTime) {
            const cardTimeMinutes = convertTimeToMinutes(cardTime.split(' ')[0]);
            const filterStartTimeMinutes = convertTimeToMinutes(startTime);
            const filterEndTimeMinutes = convertTimeToMinutes(endTime);
            
            showCard = showCard && cardTimeMinutes >= filterStartTimeMinutes && cardTimeMinutes <= filterEndTimeMinutes;
        }
        
        // Reward filter
        if (reward) {
            if (reward === 'with') {
                showCard = showCard && cardReward !== 'Reward: None';
            } else if (reward === 'without') {
                showCard = showCard && cardReward === 'Reward: None';
            }
        }
        
        // Category filter
        if (category && category !== '') {
            showCard = showCard && cardCategory === category;
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