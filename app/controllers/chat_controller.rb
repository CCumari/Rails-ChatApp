class ChatController < ApplicationController
  before_action :require_user
  
  def index
    @message = Message.new
    # Get last 50 messages in chronological order (oldest to newest for display)
    @messages = Message.includes(:user)
                      .order(created_at: :desc)
                      .limit(50)
                      .reverse
  end
  
  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      logger.info "💬 Message saved: #{@message.content} by #{@message.user.username}"
      
      rendered_message = render_message(@message)
      logger.info "📡 Broadcasting message to chat_room channel"
      
      ChatRoomChannel.broadcast_to("chat_room", {
        message: rendered_message,
        username: @message.user.username,
        message_id: @message.id
      })
      
      logger.info "✅ Message broadcast complete"
      head :ok
    else
      logger.error "❌ Message failed to save: #{@message.errors.full_messages}"
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
  
  def render_message(message)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message }
    )
  end
end
