import consumer from "channels/consumer"

// document.addEventListener('turbo:load', ()=> {

  const chatroom_element = document.getElementById('chatroom-id');


      const chatroom_id = chatroom_element.getAttribute('data-chatroom-id')
      // console.log(chatroom_id)
      
      consumer.subscriptions.create({ channel: 'ChatroomChannel', chatroom_id: chatroom_id }, {
        connected() {
          console.log('connected with room: '+chatroom_id)
        },
      
        received(data) {
          console.log(data);
        }
      });

// })
