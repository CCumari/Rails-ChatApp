module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.username
    end

    private

    def find_verified_user
      # Try session first
      if session_user_id = request.session[:user_id]
        if verified_user = User.find_by(id: session_user_id)
          return verified_user
        end
      end
      
      # Try cookies as fallback
      if cookie_user_id = cookies.signed[:user_id]
        if verified_user = User.find_by(id: cookie_user_id)
          return verified_user
        end
      end
      
      logger.error "ActionCable connection rejected - no valid user found"
      reject_unauthorized_connection
    end
  end
end
