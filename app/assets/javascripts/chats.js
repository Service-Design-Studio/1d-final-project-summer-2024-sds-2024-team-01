document.addEventListener("DOMContentLoaded", function() {
  const currentUserId = document.body.getAttribute('data-current-user-id');
  
  const urlParams = new URLSearchParams(window.location.search);
  const chatId = urlParams.get('chat_id');
  if (chatId) {
    loadChat(chatId);
  }

  document.querySelectorAll('.chat-preview').forEach(function(element) {
    element.addEventListener('click', function(event) {
      event.preventDefault();
      const chatId = this.dataset.chatId;
      loadChat(chatId);
    });
  });

  function loadChat(chatId) {
    fetch(`/chats/${chatId}`, {
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.text())
    .then(html => {
      document.getElementById('chat-content').innerHTML = html;
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
});
