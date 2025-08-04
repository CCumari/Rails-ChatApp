import consumer from "channels/consumer"

console.log("Loading chat room channel...");

const chatChannel = consumer.subscriptions.create("ChatRoomChannel", {
  connected() {
    console.log("✅ Connected to chat room channel");
  },

  disconnected() {
    console.log("❌ Disconnected from chat room channel");
  },

  received(data) {
    console.log("📨 Received data:", data);
    
    const messagesContainer = document.getElementById('messages');
    const scrollContainer = document.getElementById('messages-container');
    
    if (messagesContainer && data.message) {
      // Add the new message at the bottom (like WhatsApp)
      messagesContainer.insertAdjacentHTML('beforeend', data.message);
      
      // Auto-scroll to bottom smoothly
      if (scrollContainer) {
        scrollContainer.scrollTo({
          top: scrollContainer.scrollHeight,
          behavior: 'smooth'
        });
      }
      
      // Keep only last 50 messages to prevent memory issues
      const messageItems = messagesContainer.querySelectorAll('.message-item');
      if (messageItems.length > 50) {
        messageItems[0].remove();
      }
      
      console.log("✅ Message added to chat");
    } else {
      console.log("❌ Missing container or message data");
    }
  },

  speak: function(message) {
    return this.perform('speak', {message: message});
  }
});

// Make it available globally for debugging
window.chatChannel = chatChannel;

export default chatChannel;
