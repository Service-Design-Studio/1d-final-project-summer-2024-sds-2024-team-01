document.addEventListener('DOMContentLoaded', function() {
  const rewardTypeSelect = document.getElementById('request_reward_type');
  const rewardField = document.getElementById('request_reward');
  const form = rewardField.closest('form');

  rewardTypeSelect.addEventListener('change', function() {
    const rewardType = rewardTypeSelect.value;
    
    if (rewardType === 'None') {
      rewardField.readOnly = true;
      rewardField.value = 'None';
      rewardField.disabled = false;
    } else {
      rewardField.disabled = false;
      rewardField.readOnly = false;
      rewardField.value = rewardType === 'Money' ? '$' : '';
    }

    if (rewardType === 'Money') {
      rewardField.placeholder = 'Enter amount (e.g., $100)';
    } else if (rewardType === 'Service') {
      rewardField.placeholder = 'Describe the service you are offering';
    } else {
      rewardField.placeholder = 'If you are providing an incentive, please describe it here!';
    }
  });

  rewardField.addEventListener('input', function() {
    if (rewardTypeSelect.value === 'Money') {
      let value = rewardField.value;
      if (!value.startsWith('$')) {
        value = '$' + value;
      }
      // Remove any non-digit characters except the first '$'
      value = '$' + value.slice(1).replace(/[^\d]/g, '');
      rewardField.value = value;
    }
  });

  form.addEventListener('submit', function(event) {
    if (rewardTypeSelect.value === 'Money') {
      const moneyPattern = /^\$\d+$/;
      if (!moneyPattern.test(rewardField.value)) {
        event.preventDefault();
        alert('Please enter a valid monetary amount (e.g., $100)');
      }
    } else if (rewardTypeSelect.value === 'Service' && rewardField.value.trim() === '') {
      event.preventDefault();
      alert('Please describe the service you are offering');
    }
  });

  // Trigger change event on page load to set the initial state of the reward field
  rewardTypeSelect.dispatchEvent(new Event('change'));


  // Trigger change event on page load to set the initial state of the reward field
  rewardTypeSelect.dispatchEvent(new Event('change'));


  // Trigger change event on page load to set the initial state of the reward field
  document.getElementById('request_reward_type').dispatchEvent(new Event('change'));

  let cropper;
  const fileInputVisible = document.getElementById('file-input-visible');
  const previewImg = document.getElementById('preview-img_requests_details');
  const plusIcon = document.getElementById('plus-icon_requests_details');
  const hiddenFileInput = document.getElementById('file-input-hidden');
  const cropperContainer = document.getElementById('cropper-container');
  const cropAndUploadButton = document.getElementById('crop-and-upload');
  const clearUploadButton = document.getElementById('clear-upload');
  const uploadInstructions = document.getElementById('upload-instructions');

  plusIcon.addEventListener('click', function() {
    fileInputVisible.click();
  });

  fileInputVisible.addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        document.getElementById('image-to-crop').src = e.target.result;
        cropperContainer.style.display = 'block';
        previewImg.style.display = 'none';
        plusIcon.style.display = 'none'; // Hide the plus icon
        uploadInstructions.style.display = 'none'; // Hide the upload instructions

        if (cropper) {
          cropper.destroy();
        }
        cropper = new Cropper(document.getElementById('image-to-crop'), {
          aspectRatio: 16 / 9,
          viewMode: 1,
        });
      };
      reader.readAsDataURL(file);
    }
  });

  cropAndUploadButton.addEventListener('click', function() {
    if (cropper) {
      const canvas = cropper.getCroppedCanvas({
        width: 1600,
        height: 900,
      });
      canvas.toBlob(function(blob) {
        const url = URL.createObjectURL(blob);
        previewImg.src = url;
        previewImg.style.display = 'block';
        cropperContainer.style.display = 'none';

        const dataTransfer = new DataTransfer();
        const file = new File([blob], 'cropped-image.jpg', { type: 'image/jpeg' });
        dataTransfer.items.add(file);
        hiddenFileInput.files = dataTransfer.files;
      }, 'image/jpeg');
    }
  });

  clearUploadButton.addEventListener('click', function() {
    // Clear the preview image and cropper
    previewImg.style.display = 'none';
    previewImg.src = '#';
    cropperContainer.style.display = 'none';
    plusIcon.style.display = 'block'; // Show the plus icon
    uploadInstructions.style.display = 'block'; // Show the upload instructions

    // Clear the file inputs
    fileInputVisible.value = '';
    hiddenFileInput.value = '';

    // Destroy the cropper instance if it exists
    if (cropper) {
      cropper.destroy();
      cropper = null;
    }
  });

  previewImg.addEventListener('click', function() {
    fileInputVisible.click();
  });

  function initAutocomplete() {
    const input = document.getElementById('location');
    const autocomplete = new google.maps.places.Autocomplete(input);
  
    let place;
  
    autocomplete.addListener('place_changed', function() {
      place = autocomplete.getPlace();
      if (!place.geometry) {
        return;
      }
  
      // Store the formatted address in the hidden field immediately
      document.getElementById('stringlocation').value = place.formatted_address;
  
      // Temporarily store the place details
      document.getElementById('location').dataset.latitude = place.geometry.location.lat();
      document.getElementById('location').dataset.longitude = place.geometry.location.lng();
    });
  
    // On form submission, convert address to geocode
    const form = document.getElementById('request-form');
    form.addEventListener('submit', function(event) {
      if (place && place.geometry) {
        const latitude = place.geometry.location.lat();
        const longitude = place.geometry.location.lng();
        const pointFormat = `POINT(${longitude} ${latitude})`;
  
        // Set the hidden fields for latitude and longitude
        document.getElementById('latitude').value = latitude;
        document.getElementById('longitude').value = longitude;
  
        // Set the formatted point in the location field for submission
        document.getElementById('location').value = pointFormat;
      }
  
      // Ensure the stringlocation is set (in case it wasn't set by the place_changed event)
      if (!document.getElementById('stringlocation').value) {
        document.getElementById('stringlocation').value = input.value;
      }
  
      // Additional check to prevent submission if stringlocation is empty
      if (!document.getElementById('stringlocation').value.trim()) {
        event.preventDefault();
        alert('Please enter a valid location');
      }
    });
  }

  // Initialize Google Maps Autocomplete
  google.maps.event.addDomListener(window, 'load', initAutocomplete);

  // Initialize Flatpickr for time picker
  flatpickr("#start_time", {
  enableTime: true,
  noCalendar: true,
  dateFormat: "H:i",
  time_24hr: true,
  allowInput: true,
  onClose: function(selectedDates, dateStr, instance) {
      if (!dateStr) {
          instance.input.value = ''; // Clear the input if no valid time was selected
      }
      instance.input.dispatchEvent(new Event('change')); // Trigger change event for validation
      }
  });

  // Initialize Flatpickr for date picker with restriction
  flatpickr("#request_date", {
      minDate: "today",
      dateFormat: "Y-m-d",
      allowInput: true,
      onReady: function(selectedDates, dateStr, instance) {
          instance.set("minDate", new Date().fp_incr(1)); // Ensure date is at least 1 day after today
      },
      onChange: function(selectedDates, dateStr, instance) {
          instance.set("minDate", new Date().fp_incr(1)); // Ensure date is at least 1 day after today
      },
      onClose: function(selectedDates, dateStr, instance) {
          if (!dateStr) {
              instance.input.value = ''; // Clear the input if no valid date was selected
          }
          instance.input.dispatchEvent(new Event('change')); // Trigger change event for validation
      }
  });

  // Form validation for number of volunteers and duration
  document.getElementById('request-form').addEventListener('submit', function(event) {
    const numberOfPax = document.getElementById('number_of_pax').value;
    const duration = document.getElementById('duration').value;
    const rewardType = document.getElementById('request_reward_type').value;
    const rewardDescription = document.getElementById('request_reward').value.trim();
    const requestDate = document.getElementById('request_date');
    const startTime = document.getElementById('start_time');

    let isValid = true;

    if (parseInt(numberOfPax) <= 0) {
        document.getElementById('number_of_pax').setCustomValidity('Number of volunteers needed must be at least 1.');
        isValid = false;
    } else {
        document.getElementById('number_of_pax').setCustomValidity('');
    }

    if (parseInt(duration) <= 0) {
        document.getElementById('duration').setCustomValidity('Duration must be at least 1 hour.');
        isValid = false;
    } else {
        document.getElementById('duration').setCustomValidity('');
    }

    if (rewardType !== 'None' && (rewardDescription === '' || rewardDescription === 'None')) {
        document.getElementById('request_reward').setCustomValidity('Please provide a description for the incentive.');
        isValid = false;
    } else {
        document.getElementById('request_reward').setCustomValidity('');
    }

    // The date and time fields will be validated by the browser due to the 'required' attribute

    if (!isValid) {
        event.preventDefault();
    }
});

  // Make icons clickable and trigger the respective Flatpickr input fields
  document.getElementById('date-icon').addEventListener('click', function() {
    document.getElementById('request_date').click();
  });

  document.getElementById('time-icon').addEventListener('click', function() {
    document.getElementById('start_time').click();
  });

  // Add real-time validation for reward description
  document.getElementById('request_reward_type').addEventListener('change', function() {
    const rewardType = this.value;
    const rewardDescription = document.getElementById('request_reward');
    
    if (rewardType === 'None') {
      rewardDescription.value = 'None';
      rewardDescription.readOnly = true;
      rewardDescription.removeAttribute('required');
    } else {
      rewardDescription.value = '';
      rewardDescription.readOnly = false;
      rewardDescription.setAttribute('required', '');
    }
  });
});