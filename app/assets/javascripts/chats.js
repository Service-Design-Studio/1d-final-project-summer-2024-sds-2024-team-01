document.addEventListener("DOMContentLoaded", function() {
  const currentUserId = document.body.getAttribute('data-current-user-id');
  console.log(`Current User ID: ${currentUserId}`); // Debugging statement
  const allChats = Array.from(document.querySelectorAll('.chat-preview')); // Gather all chat previews

  const urlParams = new URLSearchParams(window.location.search);
  const chatId = urlParams.get('chat_id');
  const requestId = urlParams.get('request_id');
  if (chatId) {
    loadChat(chatId);
  }
  if (requestId) {
    filterChats('request', requestId);
  }

  function addEventListeners() {
    // Add click event listeners to chat previews
    document.querySelectorAll('.chat-preview').forEach(function(element) {
      element.addEventListener('click', function(event) {
        event.preventDefault();
        const chatId = this.dataset.chatId;
        loadChat(chatId);
      });
    });

    // Add click event listeners to filter options
    document.querySelectorAll('.filter-option').forEach(function(element) {
      element.addEventListener('click', function(event) {
        event.preventDefault();
        const filterType = this.dataset.filter;
        console.log(`Filter selected: ${filterType}`); // Debugging statement
        filterChats(filterType);
      });
    });
  }

  addEventListeners();

  function loadChat(chatId) {
    fetch(`/chats/${chatId}`, {
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.text())
    .then(html => {
      const parser = new DOMParser();
      const doc = parser.parseFromString(html, 'text/html');

      const chatContentElement = doc.querySelector('#chat-content');
      if (chatContentElement) {
        document.getElementById('chat-content').innerHTML = chatContentElement.innerHTML;
      }

      const sidebarContentElement = doc.querySelector('#sidebar-content');
      if (sidebarContentElement) {
        document.querySelector('.sidebar').innerHTML = sidebarContentElement.innerHTML;
        addEventListeners(); // Re-add event listeners for the new sidebar content
      }

      setupMessageForm(chatId);
    })
    .catch(error => console.error('Error loading chat:', error));
  }

  function setupMessageForm(chatId) {
    const messageForm = document.getElementById('message-form');
    if (messageForm) {
      messageForm.addEventListener('submit', function(event) {
        event.preventDefault();
        const formData = new FormData(this);
        fetch(`/chats/${chatId}/messages`, {
          method: 'POST',
          body: formData,
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          }
        })
        .then(response => response.json())
        .then(message => {
          const messagesDiv = document.querySelector('.message-area');
          messagesDiv.innerHTML += `<div class="message ${message.sender_id == currentUserId ? 'sent' : 'received'}">${message.message_text}</div>`;
          this.reset();
        })
        .catch(error => console.error('Error sending message:', error));
      });
    }
  }

  function filterChats(filterType, requestId = null) {
    console.log(`Filtering chats for type: ${filterType}`); // Debugging statement
    const chatList = document.getElementById('chat-list');
    
    let filteredChats = '';

    allChats.forEach(function(element) {
      const applicantId = element.dataset.applicantId;
      const requesterId = element.dataset.requesterId;
      const elementRequestId = element.dataset.requestId;
      console.log(`Chat applicant: ${applicantId}, Chat requester: ${requesterId}, Current user ID: ${currentUserId}`); // Debugging statement

      let showElement = false;

      if (filterType === 'all') {
        showElement = true; // Show all chat previews
      } else if (filterType === 'requests' && requesterId === currentUserId) {
        console.log(`Showing chat for request ID: ${element.dataset.chatId}`); // Debugging statement
        showElement = true; // Show chat previews for requests where current user is the requester
      } else if (filterType === 'applications' && requesterId !== currentUserId) {
        console.log(`Showing chat for application ID: ${element.dataset.chatId}`); // Debugging statement
        showElement = true; // Show chat previews for applications where current user is not the requester
      } else if (filterType === 'request' && requestId && elementRequestId == requestId) {
        console.log(`Showing chat for request ID: ${requestId}`); // Debugging statement
        showElement = true; // Show chat previews for the specified request
      } else {
        console.log(`Hiding chat for ID: ${element.dataset.chatId}`); // Debugging statement
        showElement = false; // Hide other chat previews
      }

      if (showElement) {
        filteredChats += element.outerHTML; // Collect the HTML of the element
      }
    });

    chatList.innerHTML = filteredChats; // Update the chat list with filtered chats
    addEventListeners(); // Re-add event listeners after filtering
  }
});
