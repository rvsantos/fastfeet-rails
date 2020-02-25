class User < ApplicationRecord
  # encrypted password
  has_secure_password

  # validates
  validates :name, :password_digest, presence: true
  validates :email, presence: true, uniqueness: { case_insensitive: true },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end
