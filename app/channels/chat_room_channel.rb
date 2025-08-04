class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for "chat_room"
    logger.info "✅ User #{current_user.username} subscribed to chat_room channel"
  end

  def unsubscribed
    logger.info "❌ User #{current_user&.username} unsubscribed from chat_room channel"
  end
end
