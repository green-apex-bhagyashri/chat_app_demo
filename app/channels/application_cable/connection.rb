module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user!
    end

    def disconnect
      Rails.logger.info("Disconnected: #{self}")
    end

    protected
    
    def find_verified_user!
      token = request.headers[:token]

      if token
        # Decode the token and find the user
        payload = JsonWebToken.decode(token)
        User.find(payload['user_id'])
      else
        reject_unauthorized_connection
      end
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      reject_unauthorized_connection
    end
  end
end
