document.addEventListener('DOMContentLoaded', function() {
    initializeFilterDropdown();
    initializeSearch();
    initializeFilters();
    initializeTimePickers();
    initializeDatePickers();
    initializeRegionFilter();
});

const singaporeRegions = {
    North: { minLat: 1.38, maxLat: 1.47, minLng: 103.70, maxLng: 103.87 },
    South: { minLat: 1.24, maxLat: 1.31, minLng: 103.80, maxLng: 103.87 },
    East: { minLat: 1.30, maxLat: 1.40, minLng: 103.92, maxLng: 104.05 },
    West: { minLat: 1.29, maxLat: 1.40, minLng: 103.60, maxLng: 103.75 },
    Central: { minLat: 1.28, maxLat: 1.37, minLng: 103.80, maxLng: 103.91 }
};

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
    const searchInput = document.getElementById('searchInput');

    searchForm.addEventListener('submit', function(e) {
        e.preventDefault();
        filterCards();
    });

    searchInput.addEventListener('input', filterCards);
}

function initializeFilters() {
    document.getElementById('rewardFilter').addEventListener('change', applyFilters);
    document.getElementById('categoryFilter').addEventListener('change', applyFilters);
}

function initializeTimePickers() {
    const startTimePicker = document.getElementById('startTimeFilter');
    const endTimePicker = document.getElementById('endTimeFilter');

    populateTimePicker(startTimePicker);
    populateTimePicker(endTimePicker);

    startTimePicker.addEventListener('change', applyFilters);
    endTimePicker.addEventListener('change', applyFilters);
}

function populateTimePicker(picker) {
    const blankOption = document.createElement('option');
    blankOption.value = "";
    blankOption.text = "Any time";
    picker.appendChild(blankOption);

    for (let i = 0; i < 24; i++) {
        const option = document.createElement('option');
        let hour = i % 12 || 12;
        let period = i < 12 ? 'AM' : 'PM';
        option.value = i.toString().padStart(2, '0') + ':00';
        option.text = `${hour}:00 ${period}`;
        picker.appendChild(option);
    }
}

function initializeDatePickers() {
    const startDatePicker = document.getElementById('startDateFilter');
    const endDatePicker = document.getElementById('endDateFilter');

    const today = new Date().toISOString().split('T')[0];
    startDatePicker.min = today;
    endDatePicker.min = today;

    startDatePicker.addEventListener('change', applyFilters);
    endDatePicker.addEventListener('change', applyFilters);
}

function initializeRegionFilter() {
    document.getElementById('regionFilter').addEventListener('change', applyFilters);
}

function getRegion(lat, lng) {
    for (const [region, bounds] of Object.entries(singaporeRegions)) {
        if (lat >= bounds.minLat && lat <= bounds.maxLat && lng >= bounds.minLng && lng <= bounds.maxLng) {
            return region;
        }
    }
    return 'Other';
}

function convertTo24Hour(time12h) {
    const [time, modifier] = time12h.split(' ');
    let [hours, minutes] = time.split(':');
    
    if (hours === '12') {
        hours = modifier === 'AM' ? '00' : '12';
    } else if (modifier === 'PM') {
        hours = parseInt(hours, 10) + 12;
    }
    
    return `${hours.toString().padStart(2, '0')}:${minutes}`;
}

function addHoursToTime(time24h, hours) {
    const [h, m] = time24h.split(':').map(Number);
    const totalMinutes = h * 60 + m + hours * 60;
    const newHours = Math.floor(totalMinutes / 60) % 24;
    const newMinutes = totalMinutes % 60;
    return `${newHours.toString().padStart(2, '0')}:${newMinutes.toString().padStart(2, '0')}`;
}

function isTimeInRange(requestStart24h, requestEnd24h, filterStart24h, filterEnd24h) {
    return requestStart24h >= filterStart24h && requestEnd24h <= filterEnd24h;
}

function filterCards() {
    applyFilters();
}

function applyFilters() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase().trim();
    const startDate = document.getElementById('startDateFilter').value;
    const endDate = document.getElementById('endDateFilter').value;
    const startTime = document.getElementById('startTimeFilter').value;
    const endTime = document.getElementById('endTimeFilter').value;
    const reward = document.getElementById('rewardFilter').value;
    const category = document.getElementById('categoryFilter').value;
    const region = document.getElementById('regionFilter').value;

    const cards = document.querySelectorAll('.request-card_requests_index');
    
    cards.forEach(card => {
        const cardDateTimeText = card.querySelector('.fas.fa-calendar-alt + span').textContent.trim();
        const [cardDateText, cardTimeText] = cardDateTimeText.split(',');
        const cardDate = new Date(cardDateText);
        const cardStartTime24h = convertTo24Hour(cardTimeText.trim());
        const cardDuration = parseFloat(card.querySelector('.fas.fa-clock + span').textContent.trim().split(' ')[0]);
        const cardEndTime24h = addHoursToTime(cardStartTime24h, cardDuration);
        const cardReward = card.querySelector('.reward-text_requests_index').textContent.trim();
        const cardCategory = card.querySelector('.card-subtitle_requests_index').textContent.trim();
        const lat = parseFloat(card.dataset.latitude);
        const lng = parseFloat(card.dataset.longitude);
        const title = card.querySelector('.card-title_requests_index').textContent.toLowerCase();
        
        let showCard = true;
        
        // Search filter
        showCard = showCard && title.includes(searchTerm);
        
        // Date range filter
        if (startDate && endDate) {
            const filterStartDate = new Date(startDate);
            const filterEndDate = new Date(endDate);
            showCard = showCard && cardDate >= filterStartDate && cardDate <= filterEndDate;
        }
        
        // Time range filter
        if (startTime && endTime) {
            showCard = showCard && isTimeInRange(cardStartTime24h, cardEndTime24h, startTime, endTime);
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

        // Region filter
        if (region) {
            const cardRegion = getRegion(lat, lng);
            showCard = showCard && cardRegion === region;
        }
        
        card.style.display = showCard ? 'block' : 'none';
    });
}