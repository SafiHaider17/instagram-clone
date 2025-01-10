import consumer from "./consumer"

document.addEventListener('turbo:load', () => { // Turbo Load event to initialize cable after page load
  
  const chatroom_element = document.getElementById('chatroom-id'); // Make sure this ID exists in your HTML
  
  if (chatroom_element) {
    const chatroom_id = chatroom_element.getAttribute('data-chatroom-id');
    console.log(chatroom_id);  // Debugging to verify the chatroom id

    consumer.subscriptions.create({ channel: 'ChatroomChannel', chatroom_id: chatroom_id }, {
      connected() {
        console.log('Connected with room: ' + chatroom_id);  // Log when connected
      },

      received(data) {
        console.log(data);  // Received data will be logged here
        // Append new message (rendered html from the backend) to the chat
        let html;
        const messageContainer = document.getElementById('chat-messages')
        messageContainer.innerHTML = messageContainer.innerHTML + data.html

        html = data.html
        var chatBox = document.getElementById('message_content')
        var mediaBox = document.getElementById('message_image')
        chatBox.value = ''
        mediaBox.value = ''
      }
    });
  }
});
