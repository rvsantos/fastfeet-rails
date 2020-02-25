class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(_token)
      body = JWT.decode(payload, SECRET_KEY)
      HashWithIndifferentAccess.new body
    end
  end
end
