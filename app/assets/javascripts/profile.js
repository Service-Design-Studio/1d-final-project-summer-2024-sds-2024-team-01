document.addEventListener('DOMContentLoaded', function() {
  // Existing modal functionality
  var modal = document.getElementById('edit_profile_pop-up');
  var btn = document.getElementById('edit-profile-btn');
  var span = document.getElementsByClassName('close')[0];

  btn.onclick = function() {
    modal.style.display = 'block';
  }

  span.onclick = function() {
    modal.style.display = 'none';
  }

  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = 'none';
    }
  }

  // New profile picture functionality
  const profileCircle = document.getElementById('profile-picture-circle');
  const fileInput = document.getElementById('avatar-input');
  const cropperContainer = document.getElementById('cropper-container');
  const cropImage = document.getElementById('image-to-crop');
  const cropAndUploadButton = document.getElementById('crop-and-upload');
  const clearUploadButton = document.getElementById('clear-upload');
  let cropper;

  profileCircle.addEventListener('click', function() {
    fileInput.click();
  });

  fileInput.addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        cropImage.src = e.target.result;
        cropperContainer.style.display = 'block';
        profileCircle.style.display = 'none';

        if (cropper) {
          cropper.destroy();
        }
        cropper = new Cropper(cropImage, {
          aspectRatio: 1,
          viewMode: 1,
          dragMode: 'move',
          cropBoxMovable: false,
          cropBoxResizable: false,
          minCropBoxWidth: 200,
          minCropBoxHeight: 200,
          cropBoxWidth: 200,
          cropBoxHeight: 200,
          guides: false,
          center: true,
          highlight: false,
          background: false,
          autoCropArea: 1,
        });
      };
      reader.readAsDataURL(file);
    }
  });

  cropAndUploadButton.addEventListener('click', function() {
    if (cropper) {
      const croppedCanvas = cropper.getCroppedCanvas({
        width: 200,
        height: 200,
      });

      croppedCanvas.toBlob(function(blob) {
        const url = URL.createObjectURL(blob);
        profileCircle.innerHTML = `<img src="${url}" class="current-avatar">`;
        profileCircle.style.display = 'block';
        cropperContainer.style.display = 'none';

        // Store the cropped image data for later use
        const dataTransfer = new DataTransfer();
        const file = new File([blob], 'cropped-avatar.jpg', { type: 'image/jpeg' });
        dataTransfer.items.add(file);
        fileInput.files = dataTransfer.files;
      }, 'image/jpeg');
    }
  });

  clearUploadButton.addEventListener('click', function() {
    profileCircle.style.display = 'block';
    cropperContainer.style.display = 'none';
    fileInput.value = '';
    if (cropper) {
      cropper.destroy();
      cropper = null;
    }
  });

  function submitForm(formData) {
    fetch(form.action, {
      method: 'PATCH',
      body: formData,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      },
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        modal.style.display = 'none';
        // Optionally update the main page profile picture here
      } else {
        console.error('Failed to update profile');
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
});