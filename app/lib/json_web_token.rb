class JsonWebToken
  # secret to encode and decode token
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class << self
    def encode(payload, exp = 24.hours.from_now)
      # set expiry to 24 hours from creation time
      payload[:exp] = exp.to_i
      # sign token with appllication secret
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(_token)
      # get payload; first index in decoded array
      body = JWT.decode(payload, SECRET_KEY)
      HashWithIndifferentAccess.new body
      # rescue from all decode errors
    rescue JWT::DecodeError => e
      # raise custom error to be handled by custom handler
      raise ExceptionHandler::InvalidToken, e.message
    end
  end
end
